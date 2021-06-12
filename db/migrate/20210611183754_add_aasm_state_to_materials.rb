class AddAasmStateToMaterials < ActiveRecord::Migration[6.1]
  def change
    add_column :materials, :aasm_state, :string
  end
end
