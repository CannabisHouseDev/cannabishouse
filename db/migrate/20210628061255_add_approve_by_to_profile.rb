class AddApproveByToProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :doctor, foreign_key: { to_table: :users }
  end
end
