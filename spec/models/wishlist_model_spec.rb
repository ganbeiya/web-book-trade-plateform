# This file tests the Wishlist model's associations and validations.
# It confirms that a wishlist entry belongs to a user and a book, and that the target price is a valid number.

require 'rails_helper'

RSpec.describe Wishlist, type: :model do
  # Wishlist must belong to a user and a book
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  # Wishlist must have a target_price that is present and greater than 0
  describe "validations" do
    it { should validate_presence_of(:target_price) }
    it { should validate_numericality_of(:target_price).is_greater_than(0) }
  end
end
