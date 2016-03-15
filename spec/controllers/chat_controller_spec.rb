require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:chat) { FactoryGirl.create(:chat) }

  describe '#index' do
    let(:participants) { [1, 2] }

    it 'when chat present' do
      get :index, participants: participants, id: chat.id
      data = JSON.parse(response.body)
      expect(data['chat']['id']).to eq chat.id
    end

    it 'when chat empty' do
      get :index, participants: participants
      expect(response).to have_http_status(204)
    end
  end

  describe '#create' do
    let(:chat_attributes) { FactoryGirl.attributes_for(:chat) }
    let(:participants) { [1, 2] }

    it 'create new chat' do
      expect do
        post :create, participants: participants, format: 'json'
      end.to change(Chat, :count).by(1)
    end
  end

  describe '#update' do
    let(:participants_ids) { chat.participants.pluck(:participant_id) << user.id }

    it 'update chat' do
      expect do
        put :update, id: chat.id, participants: participants_ids, format: :json
      end.to change(chat.participants, :count).by(1)
    end
  end

  describe '#destroy' do
    context 'when participants count higher 2' do
      let!(:participants) { FactoryGirl.create_list(:participant, 3, chat: chat) }
      it 'kill user from chat' do
        delete :destroy, participant_id: chat.participants[0].participant_id, id: chat.id, format: :json
        expect(
          Chat.current_chat(chat.id).participants[0].existing
        ).to eq(false)
      end
    end

    context 'when participants count lower or equal 2' do
      let!(:participants) { FactoryGirl.create_list(:participant, 2, chat: chat) }

      it 'destroy chat' do
        expect do
          delete :destroy, participant_id: chat.participants[0].participant_id, id: chat.id, format: :json
        end.to change(Chat, :count).by(-1)
      end
    end
  end

  describe '#list' do
    let(:chat) { FactoryGirl.create(:group_chat) }
    let!(:participants) { FactoryGirl.create_list(:participant, 3, chat: chat, participant_id: user.id) }

    it 'get chat list' do
      get :list, user_id: user.id
      data = JSON.parse(response.body)
      expect(data['id'][0]).to eq(chat.id)
    end
  end

  describe '#change_name' do
    it 'changing chat name' do
      get :change_name, id: chat.id, name: 'new_chat_name'
      data = JSON.parse(response.body)
      expect(data['name']).to eq 'new_chat_name'
    end
  end
end
