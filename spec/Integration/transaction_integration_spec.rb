# This file contains the integration tests for transaction flow

require 'rails_helper'

RSpec.describe "Transaction Flow", type: :system do
  include Devise::Test::IntegrationHelpers
  let(:buyer) { create(:user) }
  let(:seller) { create(:user) }
  let(:book) { create(:book, user: seller) }

  it "lets buyer send request and seller accept/complete" do
    sign_in buyer
    visit book_path(book)

    # Buyer sends request
    accept_confirm("Send request?") do
      click_button "Request to Buy"
    end
    expect(page).to have_content("Purchase request sent.")

    sign_out buyer
    sign_in seller

    # Seller accepts request
    visit received_requests_transactions_path
    accept_confirm("Accept this request?") do
      click_button "Accept"
    end
    expect(page).to have_content("Request accepted")

    # Move to index page where "Complete" button exists
    visit transactions_path(role: "seller", status: ["confirmed"])

    # Seller completes transaction
    accept_confirm("Mark this transaction as completed?") do
      click_button "Complete"
    end
    expect(page).to have_content("Transaction marked as completed.")
  end
end

require 'rails_helper'

RSpec.describe "Transaction Flow", type: :system do
  include Devise::Test::IntegrationHelpers
  let(:buyer) { create(:user) }
  let(:seller) { create(:user) }
  let(:book) { create(:book, user: seller) }

  it "lets buyer send request and seller accept/complete" do
    sign_in buyer
    visit book_path(book)

    # Buyer sends request
    accept_confirm("Send request?") do
      click_button "Request to Buy"
    end
    expect(page).to have_content("Purchase request sent.")

    sign_out buyer
    sign_in seller

    # Seller accepts request
    visit received_requests_transactions_path
    accept_confirm("Accept this request?") do
      click_button "Accept"
    end
    expect(page).to have_content("Request accepted")

    # Move to index page where "Complete" button exists
    visit transactions_path(role: "seller", status: ["confirmed"])

    # Seller completes transaction
    accept_confirm("Mark this transaction as completed?") do
      click_button "Complete"
    end
    expect(page).to have_content("Transaction marked as completed.")
  end
end
