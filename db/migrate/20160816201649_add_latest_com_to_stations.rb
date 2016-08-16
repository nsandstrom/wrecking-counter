class AddLatestComToStations < ActiveRecord::Migration
  def change
  	add_column :stations, :latest_com, :datetime
  end
end
