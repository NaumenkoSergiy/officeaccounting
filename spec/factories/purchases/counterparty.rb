FactoryGirl.define do
  factory :counterparty, :class => 'Counterparty' do
    name { Faker::Name.name }
    start_date { Faker::Time.between(2.days.ago, Time.now) }
  end
end
