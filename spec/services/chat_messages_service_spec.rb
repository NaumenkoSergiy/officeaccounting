require 'rails_helper'

RSpec.describe ChatMessagesService do
  let(:chatMessagesService) { ChatMessagesService.new(attrs, user) }

  describe 'index method' do
    let!(:chat) { FactoryGirl.create(:chat) }
    let!(:message) { FactoryGirl.create(:chat_message, chat: chat) }
    let!(:recipients) { FactoryGirl.create(:recipient, chat_message: message) }
    let(:user) { nil }
    let(:attrs) { { chat_id: chat.id, page: 1 } }

    it 'gets message history' do
      expect(chatMessagesService.index[0].count).to eq 1
    end
  end

  describe 'create method' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:chat) { FactoryGirl.create(:chat) }
    let!(:participants) { FactoryGirl.create_list(:participant, 2, chat: chat) }
    let(:attrs) { { chat_id: chat.id, sender_id: user.id, message_text: 'hi' } }

    before(:each) do
    end

    it 'create new message' do
      expect { chatMessagesService.create }.to change(ChatMessage, :count).by(1)
    end

    it 'create recipients' do
      expect { chatMessagesService.create }.to change(Recipient, :count).by(2)
    end
  end
end
