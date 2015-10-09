class ChatController < ApplicationController
  respond_to :json
  before_action :define_chat_service
  before_action :sort_participants, only: [:index, :create, :update]

  def index
    if chat = @chat_service.index
      render json: { chat: chat, participants: chat.participants }
    else
      head :no_content
    end
  end

  def create
    if chat = @chat_service.create
      render json: chat
    end
  end

  def update
    if chat = @chat_service.update
      render json: chat
    end
  end

  def destroy
    chat, destroyed = @chat_service.destroy
    render json: { chat: chat, destroyed: destroyed }
  end

  def list
    chat_list_name, chat_list_id, chat_id = @chat_service.chats_list
    render json: {chat_name: chat_list_name, chat_id: chat_list_id, id: chat_id}
  end

  def change_name
    chat = @chat_service.change_name
    render json: chat
  end

  private

  def sort_participants
    params[:participants].sort! if params[:participants]
  end

  def define_chat_service
    @chat_service ||= ChatService.new(params)
  end
end
