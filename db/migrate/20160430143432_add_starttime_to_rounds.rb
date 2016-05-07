class AddStarttimeToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :starttime, :datetime
  end
end
