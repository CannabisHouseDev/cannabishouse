class AddInformationsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_number, :string
    add_column :users, :pesel, :string
    add_column :users, :is_men, :boolean
    add_column :users, :skills, :text
    add_column :users, :illness, :text
    add_column :users, :nickname, :string
    add_column :users, :avatar, :string
    add_column :users, :birth_date, :date
    add_column :users, :account_balance, :integer
    add_column :users, :role, :integer
    add_column :users, :admin_log, :text
    add_column :users, :lawyer_paid, :boolean, default: false
    add_column :users, :doctor_paid, :boolean, default: false
  end
end
