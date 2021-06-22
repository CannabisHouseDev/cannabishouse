class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.references :question_type, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true
      t.integer :min
      t.integer :max
      t.string :placeholder

      t.timestamps
    end
  end
end
