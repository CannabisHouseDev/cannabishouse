class CreateMaterialTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :material_types do |t|

      t.timestamps
    end
  end
end
