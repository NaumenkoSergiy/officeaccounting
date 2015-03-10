FactoryGirl.define do
  factory :order do
    date { Faker::Date.forward(23) }
    bank_id { Faker::Number.number(2) }
    currency { Currency::AVAILABLE_CURRENCIES[rand(23)] }
    total { Faker::Number.number(9) }
    total_grn { Faker::Number.number(9) }
    rate { Faker::Number.number(4) }
    commission { Faker::Number.number(4) }
    account_grn_id { Faker::Number.number(2) }
    type_order { Faker::Name.name }
    account_rate_id { Faker::Number.number(2) }
  end
end
