# This file tests the Message model's associations and validations.
# It ensures that each message belongs to a sender, receiver, and book, and that the content is valid.

require 'rails_helper'

RSpec.describe Message, type: :model do
  # Check associations: Message must belong to sender (a User), receiver (a User), and book
  describe "associations" do
    it { should belong_to(:sender).class_name('User') }
    it { should belong_to(:receiver).class_name('User') }
    it { should belong_to(:book) }
  end

  # Validate that content must be present and less than or equal to 200 characters
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(200) }
  end
end
