class ChatMessagesController < ApplicationController
  before_action :define_chat_messages_service

  def index
    messages, recipients = @chat_messages_service.index
    respond_to do |format|
      format.json do
        render json:
          {
            messages: messages,
            recipients: recipients,
            page: params[:page].to_i + PAGE_INCREMENT
          }
      end
    end
  end

  def create
    @chat_messages_service.create
    head :created
  end

  private

  def define_chat_messages_service
    @chat_messages_service = ChatMessagesService.new(params, current_user)
  end
end
