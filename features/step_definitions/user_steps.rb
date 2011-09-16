# -*- coding: utf-8 -*-

Given /^я авторизован как пользователь с логином и паролем "([^\"]*)"$/ do |email_and_password|
  email, password = email_and_password.split("/");
  User.create!(:email => email, :password => password,:password_confirmation => password)
  visit("/users/sign_in")
  fill_in('user_email',:with => email)
  fill_in('user_password',:with => password)
  And %q(я нажму "Вход")
end

When /^(?:|я )нажму "([^"]*)"(?: с "([^"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end