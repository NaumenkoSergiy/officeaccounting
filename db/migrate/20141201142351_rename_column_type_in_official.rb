class RenameColumnTypeInOfficial < ActiveRecord::Migration
  def change
    rename_column :officials, :type, :official_type
  end
end
