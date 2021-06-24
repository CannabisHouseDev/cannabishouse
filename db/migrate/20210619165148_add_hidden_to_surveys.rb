class AddHiddenToSurveys < ActiveRecord::Migration[6.1]
  def change
    add_column :surveys, :hidden, :boolean, default: false
  end
end
