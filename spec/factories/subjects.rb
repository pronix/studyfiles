FactoryGirl.define do
  factory :subject do
    name { Faker::Lorem.words.join(' ') }
    abbreviation { Faker::Lorem.words.first.upcase }
  end
end
