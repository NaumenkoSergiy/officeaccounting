require 'rails_helper'

RSpec.describe ChatMessagesService do
  describe "index method" do
    let!(:chat) { FactoryGirl.create(:chat) }
    let!(:message) { FactoryGirl.create(:chat_message, chat: chat) }
    let!(:recipients) { FactoryGirl.create(:recipient, chat_message: message) }
    
    it "gets message history" do
      @chatMessagesService = ChatMessagesService.new({ chat_id: chat.id, page: 1 }, nil)
      expect(@chatMessagesService.index[0].count).to eq 1
    end
  end

  describe "create method" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:chat) { FactoryGirl.create(:chat) }
    let!(:participants) { FactoryGirl.create_list(:participant, 2, chat: chat) }
    before(:each) do
      @chatMessagesService = ChatMessagesService.new({ chat_id: chat.id, sender_id: user.id, message_text: "hi" }, user)
    end

    it "create new message" do
      expect { @chatMessagesService.create }.to change(ChatMessage, :count).by(1)
    end

    it "create recipients" do
      expect { @chatMessagesService.create }.to change(Recipient, :count).by(2)
    end
  end

end
