# -*- coding: utf-8 -*-

When /^(?:|я )перейду на страницу (.+)$/ do |page_name|
  visit path_to(page_name)
end