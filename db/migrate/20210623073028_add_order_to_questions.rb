class AddOrderToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :order, :integer, default: 0
  end
end
