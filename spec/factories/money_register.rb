# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :money_register do
    date "2015-02-04"
    type_document "MyString"
    counterparty_id 1
    contract_id 1
    total 1.5
    article_id 1
  end
end
