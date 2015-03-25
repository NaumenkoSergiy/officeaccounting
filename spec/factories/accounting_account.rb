FactoryGirl.define do
  factory :accounting_account, :class => 'AccountingAccount' do
    name           { Faker::Name.name }
    ap             { Faker::Name.name }
    invoice_type   { AccountingAccount::GROUPS.to_a[rand(5)][1] }
    account_number { Faker::Number.number(3) }
    subcount1      { Faker::Name.name }
    subcount2      { Faker::Name.name }
    subcount3      { Faker::Name.name }
  end
end
