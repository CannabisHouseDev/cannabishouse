class ReceiverTypoFix < ActiveRecord::Migration[6.1]
  def change
    rename_column :transfers, :reciever_id, :receiver_id
    rename_column :transfers, :reciever_material_id, :receiver_material_id
  end
end
