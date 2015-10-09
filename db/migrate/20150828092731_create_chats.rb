class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :participants_key
      t.string :name
      t.boolean :in_group, default: false

      t.timestamps null: false
    end
  end
end
