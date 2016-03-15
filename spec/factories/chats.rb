FactoryGirl.define do
  factory :chat do
    participants_key '1-2-'
    name 'chat-'
    in_group false
  end

  factory :group_chat, class: Chat do
    participants_key '1-2-3-'
    name 'chat-'
    in_group true
  end
end
