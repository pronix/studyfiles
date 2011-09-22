# -*- coding: utf-8 -*-

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

When /^(?:|я )прикреплю файл "([^\"]*)" в поле "([^\"]*)"$/ do |file_name, field|
  path = Rails.root.to_s + "/public/test/#{file_name}"

  attach_file(field, path)
end
Допустим /^я (?:перешёл|перехожу|перейду) по ссылке "([^\"]*)"$/ do |link|
  click_link(link)
end
When /^в папке "([^"]*)" появится файл с именем "([^"]*)"$/ do |folder, file_name|
  path = Rails.root.to_s + "#{folder}/#{file_name}"
  File.open(path)
end
When /^(?:|я )(?:|введу|запишу) в поле "([^\"]*)" значение "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end
Допустим /^я должен видеть "([^\"]*)"$/ do |text|
  page.should have_content(text)
end