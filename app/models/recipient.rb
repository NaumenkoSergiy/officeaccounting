class Recipient < ActiveRecord::Base
  belongs_to :chat_message
end
