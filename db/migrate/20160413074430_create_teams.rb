class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :score, null: false, default: 0 
      t.string :colour

      t.timestamps null: false
    end
  end
end
