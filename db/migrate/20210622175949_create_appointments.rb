class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.datetime :time
      t.references :doctor, null: false
      t.references :participant, null: false
      t.integer :state

      t.timestamps
    end
  end
end
