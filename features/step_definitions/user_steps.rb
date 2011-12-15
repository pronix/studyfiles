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
