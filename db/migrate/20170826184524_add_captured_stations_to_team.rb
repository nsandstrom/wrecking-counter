class AddCapturedStationsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :captured_stations, :string
  end
end
