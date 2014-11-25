FactoryGirl.define do
  password = Faker::Internet.password
  factory :user do
    email { Faker::Internet.email }
    password { password }
    confirm_password { password }
  end
end