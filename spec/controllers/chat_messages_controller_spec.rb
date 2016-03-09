require 'rails_helper'

RSpec.describe ChatMessagesController, type: :controller do

  describe "#index" do
    let!(:chat) { FactoryGirl.create(:chat) }
    let!(:message) { FactoryGirl.create(:chat_message, chat: chat) }
    let!(:recipient) { FactoryGirl.create(:recipient, chat_message: message) }

    it "get chat history" do
      get :index, chat_id: chat.id, page: '1', format: :json
      data = JSON.parse(response.body)
      expect(data['messages'][0]['id']).to eq message.id
    end
  end

  describe "#create" do
    let!(:chat) { FactoryGirl.create(:chat) }
    subject { post :create, chat_id: chat.id, sender_id: 1, message_text: "text", format: :js }
    
    it "create new message" do
      expect { subject }.to change(ChatMessage, :count).by(1)
    end

    it "response" do
      expect(subject).to have_http_status(:created)
    end
  end

end
