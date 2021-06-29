class AddScoreToFilledSurvey < ActiveRecord::Migration[6.1]
  def change
    add_column :filled_surveys, :score, :integer
  end
end
