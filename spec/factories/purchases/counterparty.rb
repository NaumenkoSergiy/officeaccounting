FactoryGirl.define do
  factory :counterparty, :class => 'Counterparty' do
    name { Faker::Name.name }
    title { Faker::Name.name }
    adress { Faker::Address.street_address }
    edrpo { Faker::Number.number(8) }
    mfo { Faker::Number.number(8) }
    account { Faker::Number.number(8) }
  end
end
