class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.integer :code_edrpo
      t.integer :mfo
      t.string :lawyer_adress

    end
  end
end
