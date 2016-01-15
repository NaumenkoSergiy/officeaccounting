class MessagesController < ApplicationController
  before_action :redirect_to_new_session

  def new
    @users = current_company ? current_company.users.pluck(:email) : []
  end

  def create
    recipients = recipients_emails(params[:recipients])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    redirect_to conversation_path(conversation)
  end

  private

  def recipients_emails(params)
    User.where(id: params.split(","))
  end
end
