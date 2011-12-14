# -*- coding: utf-8 -*-

Given /^в системе есть вузы$/ do
  University.count.should be > 0
end

Given /^в системе есть файлы$/ do
  Factory.create(:document,
      :name => "КВопросы к экзамену.doc",
      :item => File.new("#{Rails.root}/sample_documents/КВопросы к экзамену.doc"),
      :folder_id => 904
  )
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

Given /^у пользователя "(.+)" нету файлов$/ do |email|
  user = User.find_by_email(email)
  user.documents.count.should be 0
end

# т.к. капчу гугловская - то в тестовом окружении она всегда корректна
When /я должен ввести валидну капчу/ do
  true
end

Then /^получу файл с именем "(.+)"/ do |file|
  # puts page.response_headers
  page.response_headers['Content-Disposition'].should =~ /#{file}/
end

Допустим /^в университете "(.+)" есть документ "(.+)"$/ do |univer, file|
  univer = University.find_by_abbreviation(univer)
  Factory(:document, :university_id => univer.id, :folder_id => nil, :name => file)
end

Допустим /^есть следующие папки принадлежащии универу "(.+)":$/ do |univer, table|
  univer = University.find_by_abbreviation(univer)
  table.hashes.each {|h| Factory(:folder, h.merge(:university => univer))}
end

Допустим /^папка "(.+)" пренадлежит папке "(.+)"$/ do |c_folder, p_folder|
  c_folder = Folder.find_by_name(c_folder)
  c_folder.parent = Folder.find_by_name(p_folder)
  c_folder.save
end


Допустим /^в папке "(.+)" есть документ$/ do |folder|
  Factory(:document, :folder_id => Folder.find_by_name(folder).id)  
end
