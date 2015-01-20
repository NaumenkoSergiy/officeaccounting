class CreateArticle < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :code
      t.string :name

    end
  end
end
