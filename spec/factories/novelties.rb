FactoryGirl.define do
  factory :novelty do
    title Faker::Lorem.words
    text Faker::Lorem.paragraph
    main false
  end
end
