class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots do |t|
      t.boolean :booked, default: false
      t.integer :day, default: 1
      t.string :time

      t.timestamps
    end
  end
end
