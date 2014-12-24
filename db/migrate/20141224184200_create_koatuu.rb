class CreateKoatuu < ActiveRecord::Migration
  def change
    create_table :koatuus do |t|
      t.string :code
      t.string :name
    end
  end
end
