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
