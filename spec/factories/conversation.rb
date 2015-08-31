FactoryGirl.define do
  factory :conversation do
    subject { Faker::Lorem.word }
  end
  factory :messages do
    body { Faker::Lorem.word }
    subject { Faker::Lorem.word }
  end
  factory :receipts do
    is_read { false }
    trashed { false }
    end
end
