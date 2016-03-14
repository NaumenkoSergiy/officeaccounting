FactoryGirl.define do
  factory :recipient do
    recipient_id { Faker::Number.decimal(1) }
  end
end
