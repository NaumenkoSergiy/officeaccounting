class Chat < ActiveRecord::Base
  has_many :participants
  has_many :chat_messages

  validates :name, presence: true
  validates :name, length: { maximum: 15 }
  scope :is_exists, ->(key) { where(participants_key: key) }

  def self.sought_for(key)
    find_by(participants_key: key)
  end

  def current_participant(user_id)
    self.participants.find_by(participant_id: user_id)
  end

  def self.current_chat(chat_id)
    find_by_id(chat_id)
  end

  def participant_exists
    participants.where(existing: true)
  end

  def self.group_chat
    where(in_group: true)
  end
end
