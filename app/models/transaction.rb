
class Transaction < ApplicationRecord
  # Associations
  belongs_to :book
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  # Validations
  has_one :user_review, foreign_key: :book_transaction_id, dependent: :destroy

  # Status enum
  validates :status, presence: true

  enum status: {
    requested: "requested",
    confirmed: "confirmed",
    rejected: "rejected",
    completed: "completed"
  }
  
  # Check if the given user has written a review for this transaction
  def user_review_for(user)
    UserReview.find_by(reviewer: user, book_transaction: self)
  end
end
