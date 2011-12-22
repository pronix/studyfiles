# -*- coding: utf-8 -*-
#Модель для новостей на сайте
class Novelty < ActiveRecord::Base

  validates :text, :presence => true
  validates :title, :presence => true

  scope :main, where(:main => true).order('created_at DESC')

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
