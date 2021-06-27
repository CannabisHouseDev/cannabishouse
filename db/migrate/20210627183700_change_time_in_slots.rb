class ChangeTimeInSlots < ActiveRecord::Migration[6.1]
  def change
    remove_column :slots, :time
    add_column :slots, :time, :datetime
  end
end
