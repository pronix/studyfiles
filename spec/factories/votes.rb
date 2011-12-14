# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    document_id 1
    user_id 1
    vote_type false
    grade 1
  end
end
