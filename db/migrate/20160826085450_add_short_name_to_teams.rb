class AddShortNameToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :short_name, :string
  end
end
