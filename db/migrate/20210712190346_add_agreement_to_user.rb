class AddAgreementToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :agreement_1, :boolean
    add_column :users, :agreement_2, :boolean
  end
end
