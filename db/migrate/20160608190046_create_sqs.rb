class CreateSqs < ActiveRecord::Migration
  def change
    create_table :sqs do |t|
      t.string :name
      t.string :time
      t.integer :sq
      t.timestamps null: false
    end
  end
end
