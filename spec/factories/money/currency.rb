FactoryGirl.define do
  factory :currency do
    name { Currency::AVAILABLE_CURRENCIES[rand(23)] }
  end
end
