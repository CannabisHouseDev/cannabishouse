class AddOptionToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :option_id, :integer
  end
end
