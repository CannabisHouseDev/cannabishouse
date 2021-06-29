class AddRiskToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :risk, :string
  end
end
