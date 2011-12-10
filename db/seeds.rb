# -*- coding: utf-8 -*-

Rake::Task["db:fixtures:load"].invoke

Setting.create(:var => 'admin_email', :value => 'admin@example.com')

files = Document.create([
  { 
    :name => "Конспект.doc",
    :item => File.new("#{Rails.root}/sample_documents/Конспект.doc"),
    :university_id => 800,
    :folder_id => 902
  },

  {
    :name => "документ 1",
    :item => File.new("#{Rails.root}/sample_documents/документ1.doc"),
    :university_id => 800,
    :folder_id => 902
  },

  {
    :name => "Документ 3",
    :item => File.new("#{Rails.root}/sample_documents/документ3.doc"),
    :university_id => 800,
    :folder_id => 903
  },

  {
    :name => "Длинные названия и описания сокращаются до коротких названий и описаний",
    :item => File.new("#{Rails.root}/sample_documents/hugo.doc"),
    :university_id => 800,
    :folder_id => 903
  },
])
