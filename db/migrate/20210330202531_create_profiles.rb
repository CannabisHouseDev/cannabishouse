class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.integer :role
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.string :pesel
      t.integer :gender
      t.string :skills
      t.string :illness
      t.string :contact_number
      t.string :avatar
      t.date :birth_date
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
