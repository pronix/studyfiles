# -*- coding: utf-8 -*-
Допустим /^я уже имею неотредактированную новость:$/ do |table|
  table.hashes.each do |hash|
    Factory(:novelty, hash)
  end
end


Допустим /^университет "(.+)" имеет следующие предметы:$/ do |univer, table|
  univer = University.find_by_abbreviation(univer)
  table.hashes.each do |hash|
    if Subject.find_by_name(hash[:name])
      subject = Subject.find_by_name(hash[:name])
      subject.universities << univer
    else
      Factory(:subject, hash).universities << univer
    end
  end
end

Допустим /^есть университеты:$/ do |table|
  table.hashes.each {|h| Factory(:university, h)}
end

Допустим /^пользователь "(.+)" создал в универе "(.+)" папку "(.+)"$/ do |user, univer, folder|
  univer = University.find_by_abbreviation(univer)
  User.find_by_email(user).folders.create(:name => folder, :university => univer)
end

Допустим /^пользователь "(.+)" создал в папку "(.+)" в папке "(.+)"$/ do |user, child, parent|
  # Brrr brain today is stupid and lazy ((
  # OPTIMIZE:
  user = User.find_by_email(user)
  parent = user.folders.find_by_name(parent)
  child = user.folders.create(:name => child, :university => parent.university)
  child.copy_to_folder(parent)
end

Допустим /^у университете "(.+)" есть папки:$/ do |univer, table|
  # FIX: user should be from factory
  univer = University.find_by_abbreviation(univer)
  user = User.find_by_email('user@example.com')
  table.hashes.each { |h| Factory(:folder, h.merge(:university => univer, :user => user)) }
end

Допустим /^в папке "(.+)" есть следующие документы:$/ do |folder, table|
  folder = Folder.find_by_name(folder)
  table.hashes.each {|h| Factory(:document, h.merge(:folder_id => folder.id))}
end

Допустим /^мы перемещаем все документы в папку "(.+)"$/ do |folder|
  user = User.find_by_email('user@example.com')
  folder = Folder.find_by_name(folder)
  Document.move_to_folder(Document.all, folder, user)
end
