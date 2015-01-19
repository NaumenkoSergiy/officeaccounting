FactoryGirl.define do
  factory :cashier, :class => 'Cashier' do
    name { Faker::Name.name }
    currency { Currency::CURRENCY.to_a[rand(22)][1] }
  end
end
