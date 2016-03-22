class ConversationsController < ApplicationController
  before_action :redirect_to_new_session
  before_action :mailbox
  before_action :current_conversation, except: [:index, :empty_trash]
  before_action :current_box, only: [:index, :forward, :show]

  def index
    @conversations = mailbox_type.paginate(page: params[:page], per_page: 10)
  end

  def show
    render 'forward' if params[:forward]
    @conversation.mark_as_read(current_user)
  end

  def destroy
    @conversation.move_to_trash(current_user)
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def restore
    @conversation.untrash(current_user)
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def reply
    @conversation.subject.insert(0, ' RE: ')
    current_user.reply_to_conversation(@conversation, params[:body])
    redirect_to conversation_path(@conversation)
  end

  def forward
    @conversation.subject.insert(0, ' FW: ')
    recipients = recipients_emails(params[:recipients])
    conversation = current_user.send_message(recipients, current_message, @conversation.subject).conversation
    redirect_to conversation_path(conversation)
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def recipients_emails(params)
    User.where(id: params.split(','))
  end

  def current_box
    @box = params[:box].blank? ? 'inbox' : params[:box]
  end

  def current_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def current_message
    body = "#{params[:body]}\n\n"
    @conversation.receipts_for(current_user).each do |receipt|
      body += format_conversation_receipt(receipt)
    end
    body
  end

  def format_conversation_receipt(receipt)
    format_time = receipt.message.created_at.strftime('%-d %B %Y, %H:%M:%S')
    format_email = "#{@conversation.originator.email} #{t('conversations.sender_write')}"
    format_body = "#{receipt.message.body}\n\n"
    "0 #{format_time} #{format_email} #{format_body}"
  end

  def mailbox_type
    if @box.eql? 'inbox'
      @mailbox.inbox
    elsif @box.eql? 'sent'
      @mailbox.sentbox
    else
      @mailbox.trash
    end
  end
end
