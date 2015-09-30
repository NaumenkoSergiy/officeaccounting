class AddCountToNomenclatures < ActiveRecord::Migration
  def change
    add_column :nomenclatures, :count, :float
  end
end
