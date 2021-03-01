class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street_1
      t.string :street_2
      t.string :city
      t.integer :province
      t.string :zip_code
      t.string :country
      t.integer :type
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
