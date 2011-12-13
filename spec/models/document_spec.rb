require 'spec_helper'

describe Document do
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
