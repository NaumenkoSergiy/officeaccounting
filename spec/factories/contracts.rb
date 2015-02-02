# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contract do
    date "2015-02-02"
    number "MyString"
    contract_type "MyString"
    validity "2015-02-02"
  end
end
