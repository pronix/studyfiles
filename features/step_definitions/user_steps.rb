# -*- coding: utf-8 -*-

Допустим /^я зашел с логином и паролем "(.+)\/(.+)"$/ do |email, password|
  visit("/users/sign_in")
  fill_in('user_email',:with => email)
  fill_in('user_password',:with => password)
  step %{я нажму "Sign in"}
end

Given /^в системе существует пользователь с логином и паролем "(.+)\/(.+)"$/ do |email, password|
  Factory(:user, :email => email, :password => password)
end


Given /^в системе существует пользователь с логином и паролем и именем "([^\"]*)"$/ do |email_and_password_and_name|
  email, password, name = email_and_password_and_name.split("/");
  Factory(:user, :email => email, :password => password, :name => name)
end


Given /^я на (.+)$/ do |page_name|
    visit path_to(page_name)
end

Given /^я авторизован как пользователь с логином и паролем "([^\"]*)"$/ do |email_and_password|
  #Given %Q(в системе существует пользователь с логином и паролем "#{email_and_password}")
  email, password = email_and_password.split('/')
  visit("/users/sign_in")
  fill_in('user_email',:with => email)
  fill_in('user_password',:with => password)
  step %q(я нажму "Sign in")
end

When /^(?:|я )нажму "([^"]*)"(?: с "([^"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

Допустим /^в системе существует администратор с логином и паролем "(.+)\/(.+)"$/ do |email, password|
  Factory(:admin_user, :email => email, :password => password)
end

Допустим /^есть пользователи:$/ do |table|
  table.hashes.each {|h| Factory(:user, h)}
end

Допустим /^в системе есть пользователи:$/ do |table|
  table.hashes.each {|u| Factory(:user, u)}
end

Допустим /^в системе есть следующие вузы:$/ do |table|
  table.hashes.each {|u| Factory(:university, u)}
end

Допустим /^в универе "(.+)" есть следующие предметы:$/ do |univer, table|
  univer = University.find_by_abbreviation(univer)
  table.hashes.each {|s| Factory(:subject).universities << univer }
end

Допустим /^у пользователя "(.+)" в вузе "(.+)" есть документы:$/ do |user, univer, table|
  user = User.find_by_email(user)
  univer = University.find_by_abbreviation(univer)
  table.hashes.each {|d| Factory(:document,
                                 d.merge(:user => user, :university => univer,
                                         :subject => nil, :folder => nil))}
end

Допустим /^за документ "(.+)" проголосовали (\d+) раз$/ do |doc, grade|
  doc = Document.find_by_name(doc)
  Factory(:vote, :document => doc, :grade => grade.to_i)
end

Допустим /^пользователь "(.+)" из универа "(.+)"$/ do |user, univer|
  User.find_by_email(user).
    universities << University.find_by_abbreviation(univer)
end

Допустим /^пользователь "(.+)" имеет имя "(.+)"$/ do |user, name|
  User.find_by_email(user).update_attribute(:name, name)
end

Допустим /^я обновлю райтинг для вуза "(.+)"$/ do |univer|
  University.find_by_abbreviation(univer).update_user_rating!
end
