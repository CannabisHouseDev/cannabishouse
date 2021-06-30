class AddAasmStateToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :aasm_state, :string
    add_column :profiles, :old_state, :string
  end
end
