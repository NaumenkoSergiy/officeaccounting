class CreateOfficials < ActiveRecord::Migration
  def change
    create_table :officials do |t|
      t.integer :company_id
      t.string :type
      t.string :name
      t.integer :tin
      t.string :phone
      t.string :email
    end
  end
end
