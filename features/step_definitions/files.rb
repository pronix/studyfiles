# -*- coding: utf-8 -*-

Given /^в системе есть вузы$/ do 
  University.count.should be > 0
end

Given /^в системе есть файлы$/ do 
  Factory.create(:document, 
      :name => "Конспект.doc",
      :item => File.new("#{Rails.root}/sample_documents/Конспект.doc"),
      :folder_id => 902
  )
  
  Factory.create(:document, 
      :name => "Документ 1",
      :item => File.new("#{Rails.root}/sample_documents/документ1.doc"),
      :folder_id => 902
  )
  
  Factory.create(:document, 
      :name => "Документ 3",
      :item => File.new("#{Rails.root}/sample_documents/документ3.doc"),
      :folder_id => 903
  )
  
  Factory.create(:document, 
      :name => "Длинные названия и описания сокращаются до коротких названий и описаний",
      :item => File.new("#{Rails.root}/sample_documents/hugo.doc"),
      :folder_id => 903
  )
end

Given /^у пользователя "([^"]*)" нету файлов$/ do |email|
  user = User.find_by_email(email)
  user.documents.count.should be 0
end




