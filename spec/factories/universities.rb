# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :university do
    name { Faker::Lorem.words.join(' ') }
    abbreviation { Faker::Lorem.words.join(' ') }
    city "Москва"
  end
end
