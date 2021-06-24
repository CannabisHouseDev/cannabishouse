class AddDisplayToQuestionOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :question_options, :display, :string
  end
end
