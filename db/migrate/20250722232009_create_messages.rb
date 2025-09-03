# File created 7/22/2025 by Yiwen Fan
# Edited 7/22/2025 by Yiwen Fan - Changed file name into plural 
class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
