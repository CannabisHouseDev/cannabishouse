class AddGettersToProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :illness, :string
    add_column :profiles, :onboarded, :boolean, default: false
    add_column :profiles, :verified, :boolean, default: false
  end
end
