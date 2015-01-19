# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, :class => 'Account' do
    name { Faker::Name.name }
    account_type { Account::ACCOUNT.to_a[rand(8)][1] }
    number { Faker::Number.number(8) }
    currency { Currency::CURRENCY.to_a[rand(22)][1] }
    bank_id { Faker::Number.number(2) }
  end
end
