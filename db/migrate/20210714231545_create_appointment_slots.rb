class CreateAppointmentSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :appointment_slots do |t|
      t.datetime :time
      t.boolean :booked, default: false
      t.references :slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
