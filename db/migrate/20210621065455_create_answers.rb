class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :filled_survey, null: false, foreign_key: true
      t.string :content
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
