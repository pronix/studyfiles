FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'password'
    password_confirmation {|u| u.password}
  end

  factory :admin_user, :parent => :user do
    after_create { |u| u.add_role(:admin) }
  end
end
