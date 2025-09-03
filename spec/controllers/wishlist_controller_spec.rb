# This file tests the WishlistsController, including adding books to a wishlist and updating target prices.
# It ensures that users can manage their wishlists appropriately.

require 'rails_helper'

RSpec.describe WishlistsController, type: :controller do
  before do
    @user = User.create!(email: "user@example.com", password: "password")
    @book = Book.create!(title: "Wishlist Book", author: "Author", description: "desc", price: 12.0, user: @user)
    sign_in @user
  end

  describe "POST #create" do
    it "adds a book to the wishlist successfully" do
      expect {
        post :create, params: {
          wishlist: {
            book_id: @book.id,
            target_price: 9.99
          }
        }
      }.to change(Wishlist, :count).by(1)
    end
  end

  describe "PATCH #update" do
    before do
      @wishlist = Wishlist.create!(user: @user, book: @book, target_price: 10)
    end

    it "updates the wishlist's target price" do
      patch :update, params: {
        id: @wishlist.id,
        wishlist: { target_price: 15 }
      }
      expect(@wishlist.reload.target_price).to eq(15)
    end
  end
end
