class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :name
      t.boolean :active, default: false
      t.datetime :endtime, null: false
      t.text :score

      t.timestamps null: false
    end
  end
end
