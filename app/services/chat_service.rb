class ChatService
  def initialize(params)
    @params = params
  end

  def index
    @params[:goal] == 'participants' ? current_chat : find_chat
  end

  def create
    curr_chat = existing_chat(@params[:participants], @params[:id]) if @params[:id]
    if curr_chat
      restore(curr_chat, @params[:participant_id]) unless participant_state(curr_chat, @params[:participant_id])
      curr_chat
    else
      params_chat(@params[:participants])
      chat = Chat.create(participants_key: @params[:participants_key],
                         in_group: @params[:in_group],
                         name: @params[:name])
      if chat
        create_participants(chat, @params[:participants])
        chat
      end
    end
  end

  def update
    chat = current_chat
    if participant_state(chat, @params[:participant_id])
      params_chat(@params[:participants])
      if chat.update(participants_key: @params[:participants_key],
                     in_group: @params[:in_group],
                     name: @params[:name])
        update_participants(chat, @params[:participants])
      end
    else
      restore(chat, @params[:participant_id])
    end
    chat
  end

  def destroy
    if current_chat.participant_exists.count > PRIVATE_CHAT__PARTICIPANTS_COUNT
      leave(current_chat, @params[:participant_id])
      return current_chat, false
    else
      current_chat.destroy
      return nil, true
    end
  end

  def change_name
    chat = current_chat
    chat.update_attributes(name: @params[:name])
    chat
  end

  def chats_list
    chat_list_name = []
    chat_list_id = []
    chat_id = []
    Chat.group_chat.each do |chat|
      current_participant = chat.current_participant(@params[:user_id])
      next unless current_participant
      next unless current_participant.existing
      chat_list_name << chat.name
      chat_list_id << chat.participants
      chat_id << chat.id
    end
    [chat_list_name, chat_list_id, chat_id]
  end

  private

  def restore(chat, participant_id)
    @params[:participant_id] = participant_id
    @params[:existing] = true
    chat.current_participant(participant_id).update(participant_id: participant_id, existing: true)
  end

  def leave(chat, participant_id)
    @params[:participant_id] = participant_id
    @params[:existing] = false
    chat.current_participant(participant_id).update(participant_id: participant_id, existing: false)
  end

  def make_key(participants)
    key = ''
    participants.each do |participant|
      key += participant.to_s + '-'
    end
    @params[:participants_key] = key
  end

  def existing_chat(participants, chat_id)
    if chat_id.present? && current_chat.in_group
      current_chat
    elsif find_chat && participants.count < GROUP_CHAT_PARTICIPANTS_COUNT
      find_chat
    else
      false
    end
  end

  def current_chat
    Chat.current_chat(@params[:id])
  end

  def find_chat
    Chat.sought_for(make_key(@params[:participants]))
  end

  def participant_state(chat, participant_id)
    chat.current_participant(participant_id)&.existing
  end

  def create_participants(chat, participants)
    participants.each do |participant|
      chat.participants.create(participant_id: participant.to_i, existing: true)
    end
  end

  def params_chat(participants)
    make_key(participants)
    @params[:in_group] = participants.count >= GROUP_CHAT_PARTICIPANTS_COUNT
    unless @params[:name]
      @params[:name] = 'chat-'
      if Chat.last && !Chat.last.in_group
        @params[:name] += (Chat.last.id + NAME_INCREMENT).to_s
      end
    end
  end

  def update_participants(chat, participants)
    participants.each do |participant|
      unless chat.participants.exists?(participant_id: participant)
        chat.participants.create(participant_id: participant.to_i, existing: true)
      end
    end
  end
end
