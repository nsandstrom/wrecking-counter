class CreateCalibrationCodes < ActiveRecord::Migration
  def change
    create_table :calibration_codes do |t|
    	t.string :owner
    	t.integer :station_id
    	t.integer :code
    	t.boolean :completed
      t.timestamps null: false
    end
  end
end
