
class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :target_price, numericality: {greater_than: 0}, presence: true
end
