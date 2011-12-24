# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
  :remember_me, :name, :documents_attributes, :avatar, :subscriber


  has_many :documents
  has_many :votes
  has_many :downloads, :class_name => "Document", :through => :votes

  accepts_nested_attributes_for :documents, :reject_if => proc { |a| a['item'].blank? }, :allow_destroy => true

  has_many :folders

  has_many :user_universities, :dependent => :destroy
  has_many :universities, :through => :user_universities, :uniq => true

  has_inboxes

  has_and_belongs_to_many :subjects, :uniq => true
  has_and_belongs_to_many :roles, :uniq => true
  has_and_belongs_to_many :downloads, :join_table => 'users_downloads', :class_name => 'Document'

  has_attached_file :avatar, :styles => { :medium => "128x128", :thumb => "54x54", :icon => "34x34" }

  define_index do
    indexes :name
    has rating, rank
  end

  after_create :add_default_role
  
  def self.top_users(_limit=10)
    search(:order => :rank, :sort_mode => :asc).first(_limit)
  end
  
  def download_object(obj)
    if obj.class.to_s == 'Folder'
      downloads << obj.documents
      downloads << Document.where(:folder_id => obj.children.map {|f| f.id})
    else
      downloads << obj
    end
  end

  def add_default_role
    add_role('user')
  end

  def add_role(role)
    roles << Role.find_or_create_by_name(role.to_s)
  end

  def admin?
    true if roles.find_by_name('admin')
  end

  def nickname
    if !name
      return email
    end
    name
  end

  def university_subjects(univer)
    self.subjects.select { |c| c.university_ids.include?(univer.id) }
  end

  #Подсчет рейтинга пользователя
  def quick_rating
    return 0 unless documents.present?
    documents.map {|d| d.quick_rating}.sum
  end

  def get_new_documents_names(size)
    self.documents.last(size).map { |f| f.name }.join("; ")
  end

  def top_university
    return nil unless user_universities.present?
    user_universities.order('rank DESC').first.university
  end

  def top_university_rating
    return nil unless user_universities.present?
    user_universities.order('rank DESC').first.rank
  end

  # INBOXES

  def unread_messages_count
    return 0 unless speakers.present?
    unread = 0
    discussions.each do |d|
      speaker = d.speakers.find_by_user_id(id)
      unread += Message.
        where("updated_at >= ? AND discussion_id = ? AND user_id != ?",
              speaker.updated_at, d.id, id).count
    end
    unread
  end

  def all_senders
    User.find(Speaker.where("discussion_id in (?) AND user_id !=?", discussion_ids, id).map {|s| s.user_id})
  end

  def sender_messages(user)
    Message.where(:user_id => user.id, :discussion_id => discussion_ids)
  end

  def last_disscusion
    return [] unless discussions.present?
    discussions.order('updated_at DESC').first
  end

  class << self
    def overall_rating!
      r = 1
      order('rating DESC').each do |u|
        u.update_attribute(:rank, r)
        r += 1
      end
    end
  end
  
end
