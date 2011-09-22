# -*- coding: utf-8 -*-


Тогда /^в БД (?:добавится|изменится) запись в таблице документов:$/ do |table|
  table.hashes.each {|document|
    path = document[:path].split(".")
    if path[0] == "id_НГУ"
      u = University.last
      path[0] = u.id
      document[:path] = path.join(".")
    end
    Document.all(:conditions => ["item_file_name = ? AND sha = ? AND path = ?",document[:name], document[:sha], document[:path]]).size.should == 1
  }
end

Тогда /^в БД (?:добавится|изменится) запись в таблице папок:$/ do |table|
  table.hashes.each{ |current_folder|
    path = current_folder[:path].split(".")
    if path[0] == "id_НГУ"
      u = University.last
      path[0] = u.id
      current_folder[:path] = path.join(".")
    end
    Folder.all(:conditions => ["name = ? AND path = ?",current_folder[:name], current_folder[:path]]).size.should == 1
  }
end

Допустим /^я скопирую файл "([^"]*)" в папку "([^"]*)"$/ do |file_name, folder_name|
  folder = Folder.all(:conditions =>["name = ?",folder_name]).first
  document = Document.all(:conditions =>["name = ?",file_name]).first
  document.copy_to_folder(folder)
end

Тогда /^я скопирую папку "([^"]*)" в папку "([^"]*)"$/ do |folder_name1, folder_name2|
  folder1 = Folder.all(:conditions =>["name = ?",folder_name1]).first
  folder2 = Folder.all(:conditions =>["name = ?",folder_name2]).first
  folder1.copy_to_folder(folder2)
end

Тогда /^у меня есть университет "([^"]*)" с аббривиатурой "([^"]*)"$/ do |name, abbreviation|
  University.create(:id => 100, :name => name, :abbreviation => abbreviation)
end

Тогда /^я скопирую папку "([^"]*)" в университет "([^"]*)"$/ do |folder_name, university_name|
  folder = Folder.all(:conditions =>["name = ?",folder_name]).first
  u = University.all(:conditions =>["name = ?",university_name]).first
  folder.copy_to_university u
end

Тогда /^я скопирую файл "([^"]*)" в университет "([^"]*)"$/ do |file_name, university_name|
  u = University.all(:conditions =>["name = ?",university_name]).first
  document = Document.all(:conditions =>["name = ?",file_name]).first
  document.copy_to_university u
end

Тогда /^у меня есть предмет "([^"]*)" в университете "([^"]*)"$/ do |subject_name, university_name|
  s = Subject.create(:name => subject_name)
  u = University.all(:conditions =>["name = ?",university_name]).first
  u.subjects << s
end

Тогда /^я скопирую папку "([^"]*)" в предмет "([^"]*)"$/ do |folder_name, subject_name|
  s = Subject.all(:conditions =>["name = ?",subject_name]).first
  folder = Folder.all(:conditions =>["name = ?",folder_name]).first
  folder.copy_to_subject s
end

Тогда /^в БД изменится запись в таблице subject_folders:$/ do |table|
  table.hashes.each{ |rel|
    folder = Folder.all(:conditions =>["name = ?", rel[:folder]]).first
    subject = Subject.all(:conditions =>["name = ?", rel[:subject]]).first
    SubjectFolder.all(:conditions => ["folder_id = ? AND subject_id = ?", folder.id, subject.id]).size.should == 1
  }
end

Тогда /^в БД в изменится запись в таблице subject_documents:$/ do |table|
  table.hashes.each{ |rel|
    document = Document.all(:conditions =>["name = ?", rel[:document]]).first
    subject = Subject.all(:conditions =>["name = ?", rel[:subject]]).first
    SubjectDocument.all(:conditions => ["document_id = ? AND subject_id = ?", document.id, subject.id]).size.should == 1
  }
end

Тогда /^я скопирую файл "([^"]*)" в предмет "([^"]*)"$/ do |document_name, subject_name|
  s = Subject.all(:conditions =>["name = ?",subject_name]).first
  document = Document.all(:conditions =>["name = ?",document_name]).first
  document.copy_to_subject s
end

Тогда /^в таблице delayed_jobs должна появится новая запись$/ do
#  Proc.all.size.should == 1
end

Тогда /^delayed_job подхыватывает задачу$/ do
  last_document = Document.last
  file = last_document.item.path
    user = last_document.user_id
    destination = Rails.root.to_s + "/public/zips"
    files = Array.new
    Zip::ZipFile.open(file) { |zip_file|
     zip_file.each { |f|
       f_path=File.join(destination, f.name)
       FileUtils.mkdir_p(File.dirname(f_path))
       zip_file.extract(f, f_path) unless File.exist?(f_path)
       files.push(f_path)
     }
    }
    last_document.delete
    File.delete(file)
    until files.empty?
      document_path = files.pop
      if File.directory? document_path
        Dir.rmdir(document_path)
      else
        document = File.open(document_path)
        Document.create(:user_id => user, :item => document)
        File.delete(document_path)
      end
    end
end

Тогда /^по окончанию работы в табилце документов должно появится "([^"]*)" записей$/ do |count|
  (Document.all).size.should == count.to_i
end

Тогда /^файл "([^"]*)" должен быть удален\.$/ do |file_path|
  path = Rails.root.to_s + "/public/assets/documents/#{file_path}"
  File.exist?(path).should == false
end

Тогда /^в таблице delayed_jobs не должно быть записей$/ do
  Proc.all.size.should == 0
end
