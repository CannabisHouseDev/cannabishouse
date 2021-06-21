class CreateFilledSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :filled_surveys do |t|
      t.references :survey, null: false, foreign_key: true
      t.string :state, default: 'pending'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
