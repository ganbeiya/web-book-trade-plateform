class AddBookIdToUserReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_reviews, :book, null: false, foreign_key: true
  end
end
