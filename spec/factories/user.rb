FactoryGirl.define do
  password = Faker::Internet.password
  factory :user do
    id { 4 }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
