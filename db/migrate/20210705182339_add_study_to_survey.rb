class AddStudyToSurvey < ActiveRecord::Migration[6.1]
  def change
    add_reference :surveys, :study, null: false, foreign_key: true, default: 1
  end
end
