# File created 7/23/2025 by Yiwen Fan - Added 2 more fields in messages table to track deleted or not for both seller and buyer.
class AddDeletedFlagsToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :sender_deleted, :boolean
    add_column :messages, :receiver_deleted, :boolean
  end
end
