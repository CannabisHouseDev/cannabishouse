class CreateCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :cycles do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :annual_paid_on
      t.datetime :current_study_renews_on
      t.integer :monthly_cycle_start_day

      t.timestamps
    end
  end
end
