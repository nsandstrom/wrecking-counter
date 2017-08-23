class AddCalibrationRewardToStations < ActiveRecord::Migration
  def change
    add_column :stations, :reward, :integer
  end
end
