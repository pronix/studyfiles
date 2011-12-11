# -*- coding: utf-8 -*-
#Модель для новостей на сайте
class Novelty < ActiveRecord::Base

  validates :text, :presence => true
  validates :title, :presence => true

  default_scope :order => 'created_at DESC'

  scope :main, where(:main => true)

  def on_main
    self.update_attributes(:main => true)
  end

  def from_main
    self.update_attributes(:main => false)
  end

end
