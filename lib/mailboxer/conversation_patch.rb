Mailboxer::Conversation.class_eval do
  def last_message_data
    last_message.created_at.strftime("%-d %B %Y, %H:%M:%S")
  end
end
