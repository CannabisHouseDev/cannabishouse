class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :dispensary, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
