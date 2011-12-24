# -*- coding: utf-8 -*-
#Модель для новостей на сайте
class Novelty < ActiveRecord::Base
  has_many :read_notifications,
  :foreign_key => 'notification_id',
  :conditions => "notification_type = 'novelty'"

  validates :text, :presence => true
  validates :title, :presence => true

  scope :main, where(:main => true).order('created_at DESC')

  def read_news?(user)
    return false unless user
    true if read_notifications.where(:user_id => user.id).present?
  end
  
  def on_main
    update_attributes(:main => true)
  end

  def from_main
    update_attributes(:main => false)
  end

  def date
    created_at.strftime("%d %B %Y")
  end

end
