class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.belongs_to :chat
      t.integer :sender_id
      t.text :message_text

      t.timestamps null: false
    end
  end
end
