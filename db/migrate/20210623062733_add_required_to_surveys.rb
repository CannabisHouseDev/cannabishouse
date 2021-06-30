class AddRequiredToSurveys < ActiveRecord::Migration[6.1]
  def change
    add_column :surveys, :required, :boolean, default: false
    add_column :surveys, :internal_name, :string
  end
end
