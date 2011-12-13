# -*- coding: utf-8 -*-
Допустим /^я уже имею неотредактированную новость:$/ do |table|
  table.hashes.each do |hash|
    Factory(:novelty, hash)
  end
end


Допустим /^университет "(.+)" имеет следующие предметы:$/ do |univer, table|
  univer = University.find_by_abbreviation(univer)
  table.hashes.each do |hash|
    Factory(:subject, hash).universities << univer
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
