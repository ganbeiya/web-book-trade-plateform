# This file contains the controller specs for UserReviewsController

require 'rails_helper'

RSpec.describe UserReviewsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:reviewer) { create(:user) }
  let(:reviewee) { create(:user) }
  let(:book) { create(:book, user: reviewee) }
  let(:transaction) { create(:transaction, buyer: reviewer, seller: reviewee, book: book, status: "completed") }

  before { sign_in reviewer }

  describe "POST #create" do
    it "creates a new review" do
      expect {
        post :create, params: {
          user_review: {
            rating: 4,
            content: "Nice deal!",
            reviewee_id: reviewee.id,
            book_transaction_id: transaction.id
          }
        }
      }.to change(UserReview, :count).by(1)
    end
  end
end
