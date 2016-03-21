FactoryGirl.define do
  factory :participant do
    existing { true }
    sequence(:participant_id) { |n| n }
  end
end
