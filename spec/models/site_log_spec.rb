# -*- coding: utf-8 -*-
require 'spec_helper'

describe SiteLog do
  describe "Create log when create folder", :current => true do
    it "Should create logs" do
      user = Factory(:user)
      univer = Factory(:university)
      folder = Factory(:folder, :user => user, :university => univer, :name => "New Folder")
      log = SiteLog.last
      log.folder.should == folder
      log.user.should == user
      log.action.should == 'Создана папка'
    end
  end
end
