# This file contains the integration tests for user review flow

require 'rails_helper'

RSpec.describe "User Review Flow", type: :system do
  include Devise::Test::IntegrationHelpers
  let(:reviewer) { create(:user) }
  let(:reviewee) { create(:user) }
  let(:book) do
    b = create(:book, user: reviewee)
    puts "DEBUG: book.price = #{b.price.inspect}, class = #{b.price.class}"
    b
  end
  let(:transaction) { create(:transaction, buyer: reviewer, seller: reviewee, book: book, status: "completed") }

  it "lets buyer leave a review" do
    sign_in reviewer
    visit new_user_review_path(book_transaction_id: transaction.id)
    select "5", from: "Rating"
    fill_in "Comment", with: "Great experience!"
    click_button "Submit Review"
    expect(page).to have_content("Review submitted!")
  end
end
