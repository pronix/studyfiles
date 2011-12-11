# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :documents_attributes


  has_many :documents
  accepts_nested_attributes_for :documents, :reject_if => proc { |a| a['item'].blank? }, :allow_destroy => true
  has_many :folders
  has_many :messages
  has_many :votes
  has_many :user_votes,   :through => :votes, :source => :document
  has_many :user_universities, :dependent => :destroy
  has_many :universities, :through => :user_universities, :uniq => true

  has_and_belongs_to_many :roles, :uniq => true

  after_create :add_default_role
  
  def add_default_role
    add_role('user')
  end

  def add_role(role)
    roles << Role.find_or_create_by_name(role.to_s)
  end

  def is_user?
    true if roles.find_by_name('user')
  end

  def my_messages
    Message.where(["user_id = ? or to_user_id = ?", self.id, self.id])
  end

  #Подсчет рейтинга пользователя
  def raiting
    self.documents.sum(:raiting)
  end

  def get_new_documents_names(size)
    self.documents.last(size).map { |f| f.name }.join("; ")
  end
end
