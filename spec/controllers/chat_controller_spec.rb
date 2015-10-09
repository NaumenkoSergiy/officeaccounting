require 'rails_helper'

RSpec.describe ChatController, type: :controller do

  describe "#index" do
    let(:chat) { FactoryGirl.create(:chat) }

    it "when chat exists" do
      participants = [1,2]
      get :index, participants: participants, id: chat.id
      data = JSON.parse(response.body)
      expect(data["chat"]["id"]).to eq chat.id
    end
  end

  describe '#create' do
    let(:chat_attributes) { FactoryGirl.attributes_for(:chat) }

    it 'create new chat' do
      participants = [1,2]
      expect {
        post :create, participants: participants, format: 'json'
      }.to change(Chat, :count).by(1)
    end
  end

  describe '#update' do
    let!(:chat) { FactoryGirl.create(:chat) }
    let!(:participants) { FactoryGirl.create_list(:participant, 2, chat:chat) }

    it 'update chat' do
      participants_ids = [chat.participants[0].participant_id,chat.participants[1].participant_id,3]
      expect {
        put :update, participant_id: 3, id: chat.id, participants: participants_ids, format: :json
      }.to change(chat.participants, :count).by(1)
    end
  end

  describe '#destroy' do
    context 'when participants count higher 2' do
      let!(:chat) { FactoryGirl.create(:chat) }
      let!(:participants) { FactoryGirl.create_list(:participant, 3, chat:chat) }
      it 'kill user from chat' do
        delete :destroy, participant_id: chat.participants[0].participant_id, id: chat.id, format: :json
        expect(
          Chat.current_chat(chat.id).participants[0].existing
        ).to eq(false)
      end
    end

    context 'when participants count lower or equal 2' do
      let!(:chat) { FactoryGirl.create(:chat) }
      let!(:participants) { FactoryGirl.create_list(:participant, 2, chat:chat) }
      it 'destroy chat' do
        expect {
          delete :destroy, participant_id: chat.participants[0].participant_id, id: chat.id, format: :json
        }.to change(Chat, :count).by(-1)
      end
    end
  end

  describe "#list" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:chat) { FactoryGirl.create(:group_chat) }
    let!(:participants) { FactoryGirl.create_list(:participant, 3, chat: chat) }

    it "get chat list" do
      get :list, user_id: user.id
      data = JSON.parse(response.body)
      expect(data["id"][0]).to eq chat.id
    end
  end

  describe "#change_name" do
    let!(:chat) { FactoryGirl.create(:chat) }

    it "changing chat name" do
      get :change_name, id: chat.id, name: 'new_chat_name'
      data = JSON.parse(response.body)
      expect(data["name"]).to eq 'new_chat_name'
    end
  end
end
