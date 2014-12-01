class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :user_id
      t.string :full_name
      t.string :short_name
      t.string :latin_name
      t.string :juridical_address
      t.string :actual_address
      t.string :numbering_format
    end
  end
end
