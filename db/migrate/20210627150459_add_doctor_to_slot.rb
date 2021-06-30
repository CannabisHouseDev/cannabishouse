class AddDoctorToSlot < ActiveRecord::Migration[6.1]
  def change
    add_reference :slots, :user, null: false, foreign_key: true
  end
end
