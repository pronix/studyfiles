# -*- coding: utf-8 -*-
# Класс для хранения документов
class Document < ActiveRecord::Base

  require 'zip/zip'
  require 'coderay'

  has_attached_file :item,
      :url  => "/assets/documents/:first_folder/:second_folder/:sha",
      :path => ":rails_root/public/system/documents/:first_folder/:second_folder/:sha"
  
  before_save :default_name

  validates :item, :presence => true

  after_save :queue_process_item

  has_many :votes
  has_many :user_votes, :through => :votes, :source => :user

  belongs_to :user
  belongs_to :university
  belongs_to :folder
  belongs_to :subject


  scope :available, where(:tmp => false)  
  scope :unsorted, available.where(:university_id => nil)
  scope :processed, available.where(:item_proceed => true)
  scope :unfolded, available.where(:folder_id => nil)
  scope :unsubjected, available.where(:subject_id => nil)
  scope :by_univer, lambda{|univer| available.
    where(:university_id => univer.id)}

  #вытаскиваем первые два символа с хеша
  def first_folder
    self.sha[0..1]
  end

  #вытаскиваем вторую пару символов с хеша
  def second_folder
    self.sha[2..3]
  end

  #копируем файл в папку
  def copy_to_folder(folder)
    self.update_attributes(:folder_id => folder.id)
  end

  def already_processed!
    update_attribute(:item_processed, true)
  end

  def has_preview?
    item_processed and item_file_size > 0
  end

  def available!
    update_attribute(:tmp, false)
  end

  # def move_to_folder(folder)
  #   transaction do
  #     update_attribute(:folder, folder)
  #   end
  # end

  #Копируем файл в университет
  def copy_to_university(university)
    self.update_attributes(:university_id => university.id)
  end

  #Копируем файл в предмет
  def copy_to_subject(subject)
    subject.documents << self
  end

  def file_size
    size = self.item_file_size
    if size >= 100000*1000
      return "#{(self.item_file_size.to_f / (1024**3)).round(1)} Гб"
    else
      return "#{(self.item_file_size.to_f / (1024**2)).round(1)} Мб"
    end
  end


  def hard_copy_to(folder)
    FileUtils.cp_r(item.path, Rails.root.join(folder, item_file_name))
  end

  #Распаковка zip архива
  def unzip_file
    def generate_folder(path, parent=nil)
      Dir.glob(File.join(path, '*')).each do |file|
        if File.directory?(file)
          folder = Folder.create(:user => user, :name => File.basename(file))
          if parent
            folder.parent = parent
            folder.save
          end
          generate_folder(file, folder)
        else
          doc = Document.create(:user => user, :name => File.basename(file), :item => File.new(file))
          if parent
            doc.update_attribute(:folder, parent)
          end
        end
      end
    end
    
    unzipped_dir = Rails.root.join('tmp/unzipped')
    tmp_unzipped_dir = File.join(unzipped_dir, id.to_s)
    
    FileUtils.mkdir_p(unzipped_dir) unless File.exist?(unzipped_dir)
    FileUtils.rm_rf(tmp_unzipped_dir)
    
    %x[unzip #{item.path} -d #{tmp_unzipped_dir}]
    generate_folder(tmp_unzipped_dir)
  end

  def queue_process_item
    delay.file_processing if !self.item_processed
  end

  def file_processing
    process #Обрабатываем файл
    if item.content_type == 'application/zip'
      FileUtils.rm_rf(item.path)
      self.delete
    else
      available!
    end
  end

  #handle_asynchronously :unzip_file, :run_at => Proc.new { 10.second.from_now }, :priority => 0

  #Увеличение рейтинга файла при скачке
  def to_download_file
    self.raiting += (self.raiting == -1 ? 2 : 1)
  end

  #увелчение рейтинга пользователем
  def increase_raiting_by(user)
    self.raiting += (self.raiting == -1 ? 2 : 1)
    user.user_votes << self
  end

  #уменьшение рейтинга пользователем
  def decrease_raiting_by(user)
    self.raiting -= (self.raiting == 1 ? 2 : 1)
    user.votes << Vote.new(:user_id => user.id, :document_id => self.id, :vote_type => false)
  end

  #определение разрешение файла (для вывода в html)
  def extension
    self.item_file_name.split(".").last
  end

  def rating
    self.votes.sum(:grade)
  end


  def item_html
    html_path = item.path + '.html'
    return html_path if File.exist?(html_path)
  end

  #конвертирование исходного кода в html
  def default_name
    self.name = self.item_file_name if self.name.blank?
  end

  def process
    file_type = item.content_type
    case file_type
    when 'application/zip'
      unzip_file
    when 'application/msword',
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'application/rtf'
      self.office_to_html
    else
      return
      # self.source_to_html
    end
    update_attribute(:item_processed, true)
  end

  def source_to_html
    type = ""
    case self.extension
    when "rb"
      type = "ruby"
    when "pl"
      type = "python"
    when "c"
      type = "c"
    when "php"
      type = "php"
    end
    source_file = File.expand_path(self.item.path)
    highlighted = CodeRay.encode(File.read(source_file), type, :html, :css => :style, :wrap => :div)
    File.open(self.item.path + ".html", "w"){ |f| f.write(highlighted) }
  end

  #представление msofice документа кода в html
  def office_to_html
    unless File.exist? item.path + "html"
      %x[abiword --to=html #{self.item.path}]
    end
    return item.path + "html"
  end

  #предпросмотр текстового файла
  def text_to_html
    string = File.open(self.item.path, 'r'){ |file| file.read }
  end

  class << self
    # OPTIMIZE: bbbbrr
    def move_to_folder(docs, folder, user)
      docs = find(docs) if docs.first.class.to_s == 'Fixnum'
      l_parent = SiteLog.doc_move_p(docs.first.folder, user)
      docs.each do |d|
        d.update_attribute(:folder, folder)
        _log = SiteLog.doc_move_c(d, user, l_parent)
      end
    end
  end


  private
  #делаем интерполяцию, добавляем параметр первой папки
  Paperclip.interpolates :first_folder  do |attachment, style|
    attachment.instance.first_folder
  end

  #делаем интерполяцию, добавляем параметр второй папки
  Paperclip.interpolates :second_folder  do |attachment, style|
    attachment.instance.second_folder
  end

  #делаем интерполяцию, добавляем параметр имени файла
  Paperclip.interpolates :sha  do |attachment, style|
    attachment.instance.sha
  end

end
