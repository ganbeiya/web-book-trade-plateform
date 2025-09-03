class DropOrdersTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :orders, if_exists: true do |t|
      t.integer "book_id", null: false
      t.integer "buyer_id", null: false
      t.integer "seller_id", null: false
      t.decimal "book_price", precision: 8, scale: 2, null: false
      t.string "book_title", null: false
      t.string "book_condition", null: false
      t.string "book_isbn"
      t.string "status", null: false
      t.datetime "transaction_at", null: false
      t.timestamps
    end
  end
end
