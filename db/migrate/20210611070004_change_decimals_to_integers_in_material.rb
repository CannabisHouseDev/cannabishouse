class ChangeDecimalsToIntegersInMaterial < ActiveRecord::Migration[6.1]
  def change
    change_column :materials, :thc, :integer
    change_column :materials, :cbd, :integer
    change_column :materials, :terpene, :integer
    change_column :materials, :cost, :integer
  end
end
