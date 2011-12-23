# -*- coding: utf-8 -*-

When /^(?:|я )перейду на страницу (.+)$/ do |page_name|
  visit path_to(page_name)
end

Допустим /^есть следующие новости:$/ do |table|
  table.hashes.each {|h| Factory(:novelty, h)}
end

Допустим /^есть следующие вузы:$/ do |table|
  table.hashes.each {|h| Factory(:university, h)}
end


Допустим /^"(.+)" имеет реальный рейтинг "(.+)"$/ do |univer, rating|
  univer = University.find_by_abbreviation(univer)
  doc = Factory(:document, :university => univer)
  Factory(:vote, :document => doc, :grade => rating.to_i)
  univer.rating!
end

Допустим /^я не должен видеть "(.+)" в листе университетов$/ do |text|
  find(:css, '.universities-list').has_content?(text).should == false
end

Допустим /^я должен видеть "(.+)" в листе университетов$/ do |text|
  find(:css, '.universities-list').has_content?(text).should == true
end

Допустим /^речекни университеты!$/ do
  University.all.each {|u| u.recheck_available}
end
