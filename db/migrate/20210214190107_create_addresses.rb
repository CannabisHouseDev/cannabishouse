class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.integer :province
      t.string :zip_code
      t.string :country
      t.integer :category
      t.references :addressable, polymorphic: true
      t.timestamps
    end
  end
end
