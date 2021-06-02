class CreateTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :transfers do |t|
      t.references :sender_material, null: false, foreign_key: { to_table: :materials }
      t.references :reciever_material, null: false, foreign_key: { to_table: :materials }
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :reciever, null: false, foreign_key: { to_table: :users }
      t.integer :weight

      t.timestamps
    end
  end
end
