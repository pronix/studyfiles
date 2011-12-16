# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :document do
    name 'Документ 1'
    item File.new("#{Rails.root}/sample_documents/документ1.doc")
    association :university, :factory => :university
    association :folder, :factory => :folder
    association :user, :factory => :user
    association :subject, :factory => :subject
  end
end
