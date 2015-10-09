class MessagesController < ApplicationController
  def new
    @users = []
    if current_company
      @users = current_company.users.pluck(:email)
    end
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
