# -*- coding: utf-8 -*-

Given /^в системе нет файлов и папок$/ do
  Folder.all.each(&:destroy)
  Document.all.each(&:destroy)
end

Given /^в папке "([^"]*)" есть следующие файлы:$/ do |folder, table|
  folder = Folder.find_by_name(folder)
  table.hashes.each do |hash|
    user = User.find_by_name(hash[:user])
    doc = Factory(:document, :name => hash[:name], :folder_id => folder.id, :user => user)
    rating = hash[:rating].to_i
    if rating < 0
      rating.abs.times do |i|
        Factory(:bad_vote, :user => user, :document => doc)
      end
    elsif rating > 0
      rating.times do |i|
        Factory(:good_vote, :user => user, :document => doc)
      end
    end
  end
end

Then /^я должен видеть таблицу файлов:$/ do |table|
  table.hashes.each do |row|
    page.should have_content(row["rating"])
    page.should have_content(row["name"])
    page.should have_content(row["author"])
  end
end

Given /^я должен видеть элемент "([^"]*)"$/ do |arg1|
  page.has_xpath?(XPath::HTML.link(arg1))
end

Then /^кто\-то уменьшил рейтинг файла "([^"]*)"$/ do |doc|
  file = Document.find_by_name(doc)
  user = Factory(:user)
  Factory(:bad_vote, :user => user, :document => file)
end

