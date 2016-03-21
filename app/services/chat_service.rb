class ChatService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def index
    params[:goal] == 'participants' ? current_chat : find_chat
  end

  def create
    curr_chat = existing_chat(params[:participants], params[:id]) if params[:id]
    if curr_chat
      restore(curr_chat, params[:participant_id]) unless participant_state(curr_chat, params[:participant_id])
    else
      params_name(params[:participants])
      curr_chat = Chat.create(chat_params)
      return unless curr_chat
      create_participants(curr_chat, params[:participants])
    end
    curr_chat
  end

  def update
    chat = current_chat
    if participant_state(chat, params[:participant_id])
      params_name(params[:participants])
      if chat.update(chat_params)
        update_participants(chat, params[:participants])
      end
    else
      restore(chat, params[:participant_id])
    end
    chat
  end

  def destroy
    if current_chat.participant_exists.count > PRIVATE_CHAT__PARTICIPANTS_COUNT
      leave(current_chat, params[:participant_id])
      return current_chat, false
    else
      current_chat.destroy
      return nil, true
    end
  end

  def change_name
    current_chat.update_attributes(name: params[:name])
    current_chat
  end

  def chats_list
    result = Array.new(3) { [] }
    Chat.group_chat.each do |chat|
      next unless chat.current_participant(params[:user_id])&.existing
      %w(name participants id).each_with_index do |attribute, i|
        result[i] << chat.send(attribute)
      end
    end
    result
  end

  private

  def restore(chat, participant_id)
    params[:participant_id] = participant_id
    params[:existing] = true
    chat.current_participant(participant_id).update(participant_id: participant_id, existing: true)
  end

  def leave(chat, participant_id)
    params[:participant_id] = participant_id
    params[:existing] = false
    chat.current_participant(participant_id).update(participant_id: participant_id, existing: false)
  end

  def make_key(participants)
    key = participants.join('-')
    params[:participants_key] = "#{key}-"
  end

  def existing_chat(participants, chat_id)
    if chat_id.present? && current_chat.in_group
      current_chat
    elsif find_chat && participants.count < GROUP_CHAT_PARTICIPANTS_COUNT
      find_chat
    end
  end

  def current_chat
    @current_chat ||= Chat.current_chat(params[:id])
  end

  def find_chat
    @current_chat ||= Chat.sought_for(make_key(params[:participants]))
  end

  def participant_state(chat, participant_id)
    chat.current_participant(participant_id)&.existing || true
  end

  def create_participants(chat, participants)
    participants.each do |participant|
      chat.participants.create(participant_id: participant.to_i, existing: true)
    end
  end

  def params_name(participants)
    make_key(participants)
    params[:in_group] = participants.count >= GROUP_CHAT_PARTICIPANTS_COUNT
    unless params[:name]
      params[:name] = 'chat-'
      if Chat.last && !Chat.last.in_group
        params[:name] += (Chat.last.id + NAME_INCREMENT).to_s
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

  def chat_params
    {
      participants_key: params[:participants_key],
      in_group: params[:in_group],
      name: params[:name]
    }
  end
end
