class CreateStudies < ActiveRecord::Migration[6.1]
  def change
    create_table :studies do |t|
      t.string :title
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.integer :max
      t.integer :fee
      t.integer :cycle

      t.timestamps
    end
  end
end
