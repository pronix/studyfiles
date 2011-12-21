# -*- coding: utf-8 -*-
Допустим /^документа "(.+)" принадлежит папке "(.+)"$/ do |doc, folder|
  Document.find_by_name(doc).update_attribute(:folder, Folder.find_by_name(folder))
end
