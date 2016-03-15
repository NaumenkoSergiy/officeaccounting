require 'rails_helper'

RSpec.describe ChatService do
  let(:chat) { FactoryGirl.create(:chat) }
  let(:group_chat) { FactoryGirl.create(:group_chat) }

  describe 'index method' do
    let!(:chat) { FactoryGirl.create(:chat) }

    context 'goal equal participants' do
      let(:chat_service) { ChatService.new(goal: 'participants', id: chat.id) }

      it 'find current_chat by chat id' do
        expect(chat_service.index.id).to eq(chat.id)
      end
    end

    context 'goal does not equal participants' do
      let(:participants) { [1, 2] }
      let(:chat_service) { ChatService.new(goal: '', participants: participants) }

      it 'find current_chat by participants' do
        expect(chat_service.index.id).to eq(chat.id)
      end
    end
  end

  describe 'create method' do
    context 'current_chat exists' do
      let!(:participants) { FactoryGirl.create_list(:participant, 3, chat: group_chat) }

      it 'participant does not exsits in chat' do
        participants.first.update_attributes(existing: false)
        @chat_service = ChatService.new(id: group_chat.id, participant_id: participants.first.participant_id)
        expect(@chat_service.create.participants.first.existing). to eq true
      end

      it 'participant exsits in chat' do
        @chat_service = ChatService.new(id: group_chat.id, participant_id: participants.first.participant_id)
        expect(@chat_service.create.id). to eq group_chat.id
      end
    end

    context 'current_chat does not exists' do
      let(:chat_service) { ChatService.new(participants: [1, 2, 3], in_group: true, name: 'chat') }

      it 'create new chat' do
        expect { chat_service.create }.to change(Chat, :count).by(1)
      end

      it 'create participants' do
        expect { chat_service.create }.to change(Participant, :count).by(3)
      end

      it 'check chat attributes' do
        expect(chat_service.create.name).to eq 'chat'
      end
    end
  end

  describe 'update method' do
    context 'add new participant to the chat' do
      let(:chat_service) { ChatService.new(participants: [1, 2, 3], id: chat.id, in_group: true, name: 'chat') }

      it 'update chat with new participant' do
        expect { chat_service.update }.to change(chat.participants, :count).by(3)
      end

      it 'check updated attributes' do
        expect(chat_service.update.in_group).to eq(true)
      end
    end

    context 'restore participant to the chat' do
      let!(:participants) { FactoryGirl.create_list(:participant, 3, chat: group_chat) }

      it 'update chat with restored participant' do
        participants.first.update_attributes(existing: false)
        @chat_service = ChatService.new(id: group_chat.id, participant_id: participants.first.participant_id)
        expect(@chat_service.create.participants.first.existing).to eq true
      end
    end
  end

  describe 'destroy method' do
    context 'when participants count higher than 2' do
      let!(:participants) { FactoryGirl.create_list(:participant, 3, chat: chat) }
      let(:chat_service) { ChatService.new(id: chat.id, participant_id: participants.first.participant_id) }

      it 'switch participant attribute -existing- to false' do
        expect(chat_service.destroy[0].participants.first.existing).to eq(false)
      end
    end

    context 'when participants count lower or equal 2' do
      let!(:participants) { FactoryGirl.create_list(:participant, 2, chat: chat) }
      let(:chat_service) { ChatService.new(id: chat.id, participant_id: participants.first.participant_id) }

      it 'destroy chat' do
        expect { chat_service.destroy }.to change(Chat, :count).by(-1)
      end
    end
  end

  describe 'change_name method' do
    let(:chat_service) { ChatService.new(id: chat.id, name: 'newChat') }

    it 'changing chat name' do
      expect(chat_service.change_name.name).to eq('newChat')
    end
  end

  describe 'list of chats' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:participants) { FactoryGirl.create_list(:participant, 3, chat: group_chat, participant_id: user.id) }
    let(:chat_service) { ChatService.new(id: group_chat.id, user_id: user.id) }

    it 'get chats attributes' do
      expect(chat_service.chats_list[0][0]).to eq(group_chat.name)
    end
  end
end
