class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string  :personnel_number
      t.string  :type
      t.string  :name
      t.string  :passport
      t.string  :adress
      t.date  :date_birth
      t.string  :ipn
      t.references  :department, index: true
      t.references  :position, index: true
      t.references  :company, index: true
      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
