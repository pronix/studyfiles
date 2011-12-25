# -*- coding: utf-8 -*-
Допустим /^файл "(.+)" имеет только вуз$/ do |doc|
  Document.find_by_name(doc).update_attributes(:folder => nil, :subject => nil)
end

Допустим /^в предмете "(.+)" в "(.+)" есть папки:$/ do |subject, univer, table|
  subject = University.find_by_abbreviation(univer).subjects.find_by_name(subject)
  table.hashes.each {|h| Factory(:folder, h.merge({:subject => subject}))}
end

Допустим /^в папке "(.+)" есть документы:$/ do |folder, table|
  folder = Folder.find_by_name(folder)
  table.hashes.each {|h| Factory(:document, h.merge({:folder => folder}))}
end

Допустим /^папка "(.+)" должна быть первой в списке папок$/ do |folder|
  find(:xpath,
       "//a[text()=\"Предмет 1\"]/parent::div/parent::div//div[@class=\"level-1 clearfix node\"]//div//span[@class=\"file-row-title\"]//a[@class=\"expand\"]").
    text.should == folder
end

Допустим /^документ "(.+)" должен быть первый в списке документов у папки "(.+)"$/ do |doc, folder|
  find(:xpath, "//a[text()=\"#{folder}\" and @class=\"expand\"]/parent::span/parent::div//div[@class=\"level-2 clearfix node\"]//span[@class=\"file-row-title\"]/a").
    text.should == doc
end

Допустим /^у пользователя "(.+)" есть папки:$/ do |user, table|
  user = User.find_by_email(user)
  table.hashes.each {|h| Factory(:folder, h.merge({:user => user}))}
end
