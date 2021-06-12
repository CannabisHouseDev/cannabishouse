class AddQuotaToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :quota_max, :integer, default: 0
    add_column :profiles, :quota_left, :integer, default: 0
  end
end
