# -*- coding: utf-8 -*-
Допустим /^последный файл пользователя "(.+)" имеет имя "(.+)"$/ do |user, doc|
  User.find_by_email(user).documents.find_by_name(doc).should be_true
end

Допустим /^мы запустим процесс обработки файла "(.+)"$/ do |doc|
  doc = Document.find_by_name(doc)
  doc.file_processing
end

Допустим /^документ "(.+)" должен иметь статус временный$/ do |doc|
  Document.find_by_name(doc).tmp.should == true
end

Допустим /^документ "(.+)" не должен существовать$/ do |doc|
  Document.where(:name => doc).present?.should == false
end

Допустим /^документ "(.+)" должен иметь статус доступный$/ do |doc|
  Document.find_by_name(doc).tmp.should == false  
end

Допустим /^мы запустим процесс обработки всех файлов$/ do
  Document.all.each {|d| d.file_processing}
end

Допустим /^файл "(.+)" доступен$/ do |doc|
  Document.find_by_name(doc).available!
end
