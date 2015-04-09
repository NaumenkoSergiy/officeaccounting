class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.references :company, index: true
      t.timestamps
    end
  end
end
