# This file contains the model specs for Transaction

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:book) }
  it { should belong_to(:buyer).class_name("User") }
  it { should belong_to(:seller).class_name("User") }
  it { should have_one(:user_review).dependent(:destroy) }

  it { should validate_presence_of(:status) }

  it "has valid enum statuses" do
    expect(Transaction.statuses.keys).to contain_exactly("requested", "confirmed", "rejected", "completed")
  end
end
