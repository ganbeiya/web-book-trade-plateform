# This file contains the model specs for UserReview

require 'rails_helper'

RSpec.describe UserReview, type: :model do
  it { should belong_to(:reviewer).class_name("User") }
  it { should belong_to(:reviewee).class_name("User") }
  it { should belong_to(:book_transaction).class_name("Transaction") }

  it { should validate_presence_of(:rating) }
  it { should validate_inclusion_of(:rating).in_range(1..5) }
  it { should validate_length_of(:content).is_at_most(300) }
end
