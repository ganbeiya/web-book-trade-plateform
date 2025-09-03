class AddReplyStatusToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :replied_by_receiver, :boolean
    add_column :messages, :replied_by_sender, :boolean
  end
end
