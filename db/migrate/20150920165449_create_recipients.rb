class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.belongs_to :chat_message
      t.integer :recipient_id

      t.timestamps null: false
    end
  end
end
