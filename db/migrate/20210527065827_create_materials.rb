class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.references :material_type, null: false, foreign_key: { to_table: :material_types }
      t.string :name
      t.string :description
      t.integer :weight
      t.decimal :thc
      t.decimal :cbd
      t.decimal :terpene
      t.boolean :drought, default: false
      t.boolean :oil, default: false
      t.boolean :edible, default: false
      t.decimal :cost
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
