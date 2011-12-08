class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :documents_attributes


  has_many :documents
  accepts_nested_attributes_for :documents
  has_many :folders
  has_many :messages
  has_many :votes
  has_many :user_votes,   :through => :votes, :source => :document
  has_many :user_universities, :dependent => :destroy
  has_many :universities, :through => :user_universities, :uniq => true

  def my_messages
    Message.where(["user_id = ? or to_user_id = ?", self.id, self.id])
  end

  #Подсчет рейтинга пользователя
  def raiting
    self.documents.sum(:raiting)
  end

end
