class CreateStudyParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :study_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :study, null: false, foreign_key: true

      t.timestamps
    end
  end
end
