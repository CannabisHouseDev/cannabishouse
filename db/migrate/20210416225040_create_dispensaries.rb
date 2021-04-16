class CreateDispensaries < ActiveRecord::Migration[6.1]
  def change
    create_table :dispensaries do |t|
      t.string :name
      t.string :description
      t.string :avatar
      t.string :category
      t.string :documents
      t.boolean :verified
      t.boolean :open
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
