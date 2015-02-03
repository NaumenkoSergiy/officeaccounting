FactoryGirl.define do
  factory :contract do
    date { Faker::Date.between(2.days.ago, Date.today) }
    number { Faker::Number.number(8) }
    contract_type { Contract::CONTRACT_TYPE.to_a[rand(2)][1] }
    validity { Faker::Date.between(2.days.ago, Date.today) }
  end
end
