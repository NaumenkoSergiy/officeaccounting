class AddPdvToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :pdv, :boolean
  end
end
