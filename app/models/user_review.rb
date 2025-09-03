
class UserReview < ApplicationRecord
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewee, class_name: "User"

  belongs_to :book_transaction, class_name: "Transaction"

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, length: { maximum: 300 }

  # Prevent duplicate reviews for the same transaction
  validates :book_transaction_id, uniqueness: { message: "has already been reviewed." }
end
