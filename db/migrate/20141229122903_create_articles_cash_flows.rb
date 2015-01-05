class CreateArticlesCashFlows < ActiveRecord::Migration
  def change
    create_table :articles_cash_flows do |t|
      t.integer :code
      t.string :name

    end
  end
end
