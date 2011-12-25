# -*- coding: utf-8 -*-
Допустим /^файл "(.+)" имеет только вуз$/ do |doc|
  Document.find_by_name(doc).update_attributes(:folder => nil, :subject => nil)
end
