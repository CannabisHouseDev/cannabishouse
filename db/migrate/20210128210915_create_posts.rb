class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :status
      t.references :user, null: false, foreign_key: true, index: true
      t.datetime :post_date
      t.string :image
      t.string :slug
      t.boolean :inner

      t.timestamps
    end
  end
end
