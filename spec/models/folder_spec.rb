require 'spec_helper'

def unzip(file)
  destination = Rails.root.join('public/system/ziped_clients')
  %x[cd #{destination} && unzip #{file}]
end

def has_files?(dir, files)
  files.each do |f|
    return false unless File.exist?(File.join(dir, f))
  end
  true
end

describe Folder do
  describe "Delte folder" do
    it "Should delete all files and subfolders" do
      main_folder = Factory(:folder)
      s_folder = Factory(:folder)
      s_folder.parent = main_folder
      s_folder.save
      main_folder.children.present?.should == true
      doc1 = Factory(:document, :folder => main_folder)
      doc2 = Factory(:document, :folder => s_folder)
      main_folder.destroy
      Folder.find_by_id(main_folder.id).present?.should == false
      Document.find_by_id(doc1.id).present?.should == false
      Folder.find_by_id(s_folder.id).present?.should == false
      Document.find_by_id(doc2.id).present?.should == false
    end
  end
  describe "Zip folder" do
    before(:all) do
      @zip_path = Rails.root.join('public/system/ziped_clients')
      @doc_file1 = File.new(Rails.root.join('test/fixtures/files/document1.doc'))
      @doc_file2 = File.new(Rails.root.join('test/fixtures/files/document2.doc'))
    end
    before(:each) do
      FileUtils.rm_r Dir.glob(Rails.root.join('public/system/ziped_clients/*'))
    end
    describe "Create zip folder with only files" do
      before(:each) do
        @folder = Factory(:folder)
      end

      it "Should zipped folder with files" do
        Factory(:document, :folder_id => @folder.id,
                :item => @doc_file1)
        Factory(:document, :folder_id => @folder.id,
                :item => @doc_file2)
        zip_path = @folder.zip_folder
        File.exist?(Rails.root.join(zip_path)).should == true
        unzip zip_path
        File.exist?(Rails.root.join(@zip_path, 'document1.doc'))
        File.exist?(Rails.root.join(@zip_path, 'document2.doc'))
      end
    end

    describe "Create zip folder with folders tree only" do
      before(:each) do
        @folder = Factory(:folder)

        @folder1_1 = Factory(:folder)
        @folder1_1.parent = @folder
        @folder1_1.save

        @folder1_2 = Factory(:folder)
        @folder1_2.parent = @folder
        @folder1_2.save

        @folder1_1_1 = Factory(:folder)
        @folder1_1_1.parent = @folder1_1
        @folder1_1_1.save

        Factory(:document, :folder_id => @folder1_1_1.id, :item => @doc_file1)
      end

      it "Should create zipped folder with folder tree" do
        zip_path = @folder.zip_folder
        zip_path.should == Rails.root.join('public/system/ziped_clients', "#{@folder.id.to_s}.zip")
        unzip(zip_path)
        Dir.glob(File.join(@zip_path, @folder.id.to_s, '*
*', '*.doc')).present?.should == true
      end
    end
    
  end
end
