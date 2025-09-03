class AddBookTransactionIdToUserReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :user_reviews, :book_transaction_id, :integer, null: false
    add_foreign_key :user_reviews, :transactions, column: :book_transaction_id
    add_index :user_reviews, :book_transaction_id
  end
end
