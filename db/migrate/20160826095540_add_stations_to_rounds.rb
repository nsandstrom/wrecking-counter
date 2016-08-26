class AddStationsToRounds < ActiveRecord::Migration
  def change
  	add_column :rounds, :stations, :integer, default: 15
  end
end
