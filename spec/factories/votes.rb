# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :vote do
    association :user, :factory => :user
    association :document, :factory => :document
    vote_type true
    grade 1
  end
  factory :good_vote, :class => Vote do
    vote_type true
    grade 1
  end
  factory :bad_vote, :class => Vote do
    vote_type false
    grade -1
  end
end
