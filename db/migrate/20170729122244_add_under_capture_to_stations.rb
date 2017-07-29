class AddUnderCaptureToStations < ActiveRecord::Migration
  def change
    add_column :stations, :under_capture, :boolean
  end
end
