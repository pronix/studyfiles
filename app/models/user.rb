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

  has_attached_file :avatar, :styles => { :medium => "128x128", :thumb => "54x54", :icon => "34x34" }

  after_create :add_default_role

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
  def raiting
    return 0 unless documents.present?
    documents.map {|d| d.rating}.sum
  end

  def get_new_documents_names(size)
    self.documents.last(size).map { |f| f.name }.join("; ")
  end

  def top_university
    return nil unless user_universities.present?
    user_universities.order('rating DESC').first.university
  end

  def top_university_rating
    return nil unless user_universities.present?
    user_universities.order('rating DESC').first.rating
  end

  # INBOXES

  def unread_messages
    speaker = Speaker.find_by_user_id(self.id)
    return [] unless speaker.present?
    Message.where("discussion_id in (?) AND user_id != ? AND updated_at > ?",
                  discussion_ids, self.id, speaker.updated_at)
  end

  def unread_message_count
    unread_messages.count
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
end
