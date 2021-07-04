class AddAasmStateToCycle < ActiveRecord::Migration[6.1]
  def change
    add_column :cycles, :aasm_state, :string
  end
end
