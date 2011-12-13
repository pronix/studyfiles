# -*- coding: utf-8 -*-
require 'spec_helper'

# OPTIMIZE: REFACTOR: KILLME:
describe SiteLog do
  describe "Create log when create folder" do
    it "Should create logs" do
      user = Factory(:user)
      univer = Factory(:university)
      folder = Factory(:folder, :user => user, :university => univer, :name => "New Folder")
      log = SiteLog.last
      log.relation_id.should == folder.id
      log.relation_type.should == folder.class.to_s
      log.user.should == user
      log.action.should == 'create_folder'
    end
  end

  describe "Create log when folder move", :current => true do
    it "Should create logs" do
      s_folder = Factory(:folder)
      d_folder = Factory(:folder)
      user = Factory(:user)
      doc1 = Factory(:document, :folder_id => s_folder.id)
      doc2 = Factory(:document, :folder_id => s_folder.id)
      Document.move_to_folder([doc1, doc2], d_folder, user)
      root_log = SiteLog.top_level.find_by_action('move_docs')
      root_log.children.size.should == 2
    end
  end
end
