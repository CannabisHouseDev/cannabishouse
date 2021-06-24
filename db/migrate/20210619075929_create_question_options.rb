class CreateQuestionOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :question_options do |t|
      t.string :name
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
