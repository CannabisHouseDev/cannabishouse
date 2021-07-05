class UpdateQuotaInProfile < ActiveRecord::Migration[6.1]
  def change
    rename_column :profiles, :quota_max, :quota_max_dry
    rename_column :profiles, :quota_left, :quota_left_dry
    add_column :profiles, :quota_max_oil, :integer, default: 0
    add_column :profiles, :quota_left_oil, :integer, default: 0
  end
end
