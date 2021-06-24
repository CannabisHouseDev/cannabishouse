class AddLockedToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :locked, :boolean, default: false
  end
end
