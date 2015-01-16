# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, :class => 'Accounts' do
    name "MyString"
    account_type "MyString"
    number 1
    currency "MyString"
    bank "MyString"
  end
end
