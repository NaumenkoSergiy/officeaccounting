FactoryGirl.define do
  factory :currency do
    name { Currency::CURRENCY.to_a[rand(22)][1] }
  end
end
