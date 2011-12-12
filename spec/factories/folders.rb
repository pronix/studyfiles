FactoryGirl.define do
  factory :folder do
    name Faker::Lorem.words.join(' ')
    association :user, :factory => :user
    association :university, :factory => :university
  end
end
