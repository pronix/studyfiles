# -*- coding: utf-8 -*-
Допустим /^последный файл пользователя "(.+)" имеет имя "(.+)"$/ do |user, doc|
  User.find_by_email(user).documents.find_by_name(doc).should be_true
end

Допустим /^мы запустим процесс обработки файла "(.+)"$/ do |doc|
  doc = Document.find_by_name(doc)
  doc.file_processing
end
