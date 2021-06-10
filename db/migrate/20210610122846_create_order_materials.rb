class CreateOrderMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :order_materials do |t|
      t.references :order, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true

      t.timestamps
    end
  end
end
