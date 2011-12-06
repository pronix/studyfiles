# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :document do
    name 'Документ 1'
    item File.new("#{Rails.root}/sample_documents/документ1.doc")
    university_id 800
    folder_id 902
  end
end
