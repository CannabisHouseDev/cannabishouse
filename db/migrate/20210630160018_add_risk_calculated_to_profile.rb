class AddRiskCalculatedToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :risk_calculated, :integer
  end
end
