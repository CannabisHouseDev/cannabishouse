class AddSurveyColumn < ActiveRecord::Migration[6.1]
  def change
    add_reference :surveys, :study, foreign_key: true
  end
end
