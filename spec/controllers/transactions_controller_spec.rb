# This file contains the controller specs for TransactionsController

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }
  let(:book) { create(:book, user: user) }
  let(:transaction) { create(:transaction, book: book, seller: user, status: "confirmed") }

  before { sign_in user }

  describe "GET #index" do
    it "returns success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH #complete" do
    it "completes the transaction if seller" do
      patch :complete, params: { id: transaction.id }
      expect(transaction.reload.status).to eq("completed")
    end
  end
end
