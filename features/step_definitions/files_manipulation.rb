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
