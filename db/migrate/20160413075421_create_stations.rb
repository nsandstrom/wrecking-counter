class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :location
      t.belongs_to :team, index: true, foreign_key: true
      t.integer :boost, default: 100, null: false

      t.timestamps null: false
    end
  end
end
