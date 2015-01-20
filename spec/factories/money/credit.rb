FactoryGirl.define do
  factory :credit do
    name { Faker::Name.name }
    credit_type { Credit::CREDIT_TYPE.to_a[rand(2)][0] }
    account_number { Faker::Number.number(13) }
  end
end
