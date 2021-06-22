class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.date :date, null: false
      t.integer :state, null: false, default: 0
      t.datetime :time

      t.timestamps
    end
  end
end
