class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :chat
      t.integer :participant_id
      t.boolean :existing
      t.timestamps null: false
    end
  end
end
