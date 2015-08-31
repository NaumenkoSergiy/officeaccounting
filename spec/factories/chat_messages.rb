FactoryGirl.define do
  factory :chat_message do
    sender_id { Faker::Number.decimal(1) }
    message_text { Faker::Lorem.characters(5) }
  end

end
