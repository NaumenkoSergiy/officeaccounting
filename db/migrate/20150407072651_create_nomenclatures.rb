class CreateNomenclatures < ActiveRecord::Migration
  def change
    create_table :nomenclatures do |t|
      t.string  :title
      t.string  :type
      t.references :guide_unit, index: true
      t.references :accounting_account, index: true
      t.references :company, index: true
      t.timestamps
    end
  end
end
