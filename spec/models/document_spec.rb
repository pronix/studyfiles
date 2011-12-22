# -*- coding: utf-8 -*-
require 'spec_helper'

describe Document do

  describe "Create doc_txt" do
    before(:each) do
      @doc = Factory(:document,
                     :folder => nil,
                     :subject => nil,
                     :university => nil,
                     :item => File.new(Rails.root.join('sample_documents/сознание.doc')))
    end

    it "Should create doc_txt field" do
      @doc.file_processing
      @doc.txt_doc.present?.should be_true
      File.exist?(@doc.item.path + '.txt').should == false
      File.exist?(@doc.item.path + '.html').should == true
      File.exist?(@doc.item.path + '.txt.bak').should == false
    end
  end
  
  describe "Unzip document" do
    before(:each) do
      FileUtils.rm_rf(Rails.root.join('tmp/unzipped'))
      @doc = Factory(:document,
                     :folder => nil,
                     :subject => nil,
                     :university => nil,
                     :item => File.new(Rails.root.join('sample_documents/test_archive.zip')))
    end
    before(:all) do
      @unzipped_dir = Rails.root.join('tmp/unzipped')
    end

    it "Should unzip archive" do
      @doc.unzip_file
      File.exist?(@unzipped_dir).should == true
      File.exist?(File.join(@unzipped_dir, @doc.id.to_s, 'test_archive')).should == true
      File.exist?(File.join(@unzipped_dir, @doc.id.to_s, 'test_archive/sozdanie.doc')).should == true
      File.exist?(File.join(@unzipped_dir, @doc.id.to_s, 'test_archive/folder_1/vshe.gif')).should == true
      Document.find_by_name('sozdanie.doc').should be_true
      Document.find_by_name('vshe.gif').should be_true
      Document.find_by_name('sozdanie.doc').folder.name.should == 'test_archive'
      Document.find_by_name('sozdanie.doc').folder.path.should == ''
      Document.find_by_name('vshe.gif').folder.parent.should == Folder.find_by_name('test_archive')
    end

    it "Should delete arhive after processing" do
      @doc.file_processing
      Document.where(:id => @doc.id).present?.should == false
    end
    
  end
  
  describe "Move documents to folder" do
    before(:each) do
      @folder = Factory(:folder)
      @d_folder = Factory(:folder)
      @doc1 = Factory(:document, :folder_id => @folder.id)
      @doc2 = Factory(:document, :folder_id => @folder.id)
    end

    it "Should move documents as Documnet to folder" do
      Document.move_to_folder([@doc1, @doc2], @d_folder)
      @doc1.folder.should == @d_folder
      @doc2.folder.should == @d_folder
    end

    it "Should move documents as ids to folder" do
      Document.move_to_folder([@doc1.id, @doc2.id], @d_folder)
      Document.find(@doc1).folder.should == @d_folder
      Document.find(@doc2).folder.should == @d_folder
    end
  end
end
