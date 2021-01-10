class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.boolean :show_in_menu, default: false
      t.string :slug
      t.integer :position
      t.boolean :inner, default: false

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
