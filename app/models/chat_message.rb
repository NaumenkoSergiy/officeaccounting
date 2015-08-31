class ChatMessage < ActiveRecord::Base
  has_many :recipients
  belongs_to :chat
end
