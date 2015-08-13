class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string  :title
      t.references :company, index: true
      t.timestamps
    end
  end
end
