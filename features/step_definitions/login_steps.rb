# -*- coding: utf-8 -*-
Допустим /^я должен увидеть "(.+)" в юзербаре$/ do |text|
  find_by_id('user-bar').should have_content(text)
end

Допустим /^поле "(.+)" должны быть "(.+)"$/ do |field, value|
  find_field(field).value.should == value
end
