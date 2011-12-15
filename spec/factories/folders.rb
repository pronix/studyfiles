FactoryGirl.define do
  factory :folder do
    name { Faker::Lorem.words.join(' ') }
    description { Faker::Lorem.paragraph }
    association :user, :factory => :user
    association :university, :factory => :university
    association :subject, :factory => :subject
  end
end
