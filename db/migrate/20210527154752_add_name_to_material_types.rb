class AddNameToMaterialTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :material_types, :name, :string
  end
end
