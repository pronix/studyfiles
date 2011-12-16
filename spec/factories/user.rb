FactoryGirl.define do
  factory :user do
    association :university, :factory => :university

    email { Faker::Internet.email }
    password 'password'
    password_confirmation {|u| u.password}
    name { Faker::Name.name }
  end

  factory :admin_user, :parent => :user do
    after_create { |u| u.add_role(:admin) }
  end
end
