class ChatMessagesService
  def initialize(params, current)
    @current_user = current
    @params = params
  end

  def index
    if page = @params[:page].to_i
      message_history_info(page)
    end
  end

  def create
    if message = ChatMessage.create(chat: current_chat, sender_id: @params[:sender_id], message_text: @params[:message_text])
      recipients(message)
      broadcast(message)
    end
  end

  private

  def message_history_info(page_num)
    recipients = []
    current_chat.chat_messages.each do |message|
      Recipient.where(chat_message_id: message.id).each do |recipient|
        recipients << recipient
      end
    end
    return current_chat.chat_messages.order(created_at: :desc).page(page_num).per_page(10), recipients
  end

  def current_chat
    Chat.current_chat(@params[:chat_id])
  end

  def recipients(message)
    @params[:recipients] = []
    current_chat.participants.each do |participant|
      if participant.existing
        @params[:recipient_id] = participant.participant_id
        message.recipients.create(recipient_id: @params[:recipient_id])
        unless participant.participant_id == @current_user.id
          @params[:recipients] << participant.participant_id
        end
      end
    end
  end

  def broadcast(message)
    @params[:recipients].each do |recipient_id|
      ActionCable.server.broadcast("chat_#{recipient_id}",
                                   chat_id: @params[:chat_id],
                                   sender_id: @params[:sender_id],
                                   recipients: @params[:recipients],
                                   message_text: message.message_text)
    end
  end
end
