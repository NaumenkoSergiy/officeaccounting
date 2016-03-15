FactoryGirl.define do
  factory :cashier, class: 'Cashier' do
    name { Faker::Name.name }
    currency { Currency::AVAILABLE_CURRENCIES[rand(22)] }
  end
end
