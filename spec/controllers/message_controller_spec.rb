# This file tests the MessagesController, including the creation and soft deletion of messages.
# It verifies that authenticated users can send messages related to a book and soft-delete them properly.

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  before do
    @user = User.create!(email: "user1@example.com", password: "password", username: "sender01")
    @receiver = User.create!(email: "user2@example.com", password: "password", username: "receiver01")
    @book = Book.create!(title: "Book", author: "Author", description: "desc", price: 20.0, user: @receiver, condition: "New")
    sign_in @user
  end

  describe "POST #create" do
    it "creates a new message successfully" do
      expect {
        post :create, params: {
          message: {
            content: "Hello there",
            receiver_id: @receiver.id,
            book_id: @book.id
          }
        }
      }.to change(Message, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    before do
      @message = Message.create!(
        content: "Hi",
        sender: @user,
        receiver: @receiver,
        book: @book
      )
    end

    it "soft deletes the message for the sender" do
      delete :destroy, params: { id: @message.id }
      expect(@message.reload.sender_deleted).to be true
    end
  end
end
