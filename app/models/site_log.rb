# -*- coding: utf-8 -*-
class SiteLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :folder

  class << self
    # OPTIMIZE: brr hell ))
    def create_foler(folder, action='Создана папка')
      _log = self.new
      _log.user = folder.user
      _log.folder = folder
      _log.action = action
      _log.save
    end
  end
end
