
class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:accept, :complete]

  # Displays all transactions where the current user is a buyer or seller
  def index
    role = params[:role]
    statuses = Array(params[:status])

    # Initial query: all transactions involving the current user (as buyer or seller)
    @transactions = Transaction.includes(:book)
                              .where("buyer_id = ? OR seller_id = ?", current_user.id, current_user.id)

    # Role filter: Buyer or Seller
    if role == "buyer"
      @transactions = @transactions.where(buyer_id: current_user.id)
    elsif role == "seller"
      @transactions = @transactions.where(seller_id: current_user.id)
    end

    # Status filter: multiple allowed
    if statuses.any?
      @transactions = @transactions.where(status: statuses)
    end

    @transactions = @transactions.order(created_at: :desc)
  end

  # Displays purchase requests received by the current user (as seller), grouped by book
  def received_requests
    @transactions = Transaction.includes(:book, :buyer)
                               .where(seller: current_user)
                               .order(:created_at)
                               .group_by(&:book)
  end

  # Displays all purchase requests sent by the current user (as buyer)
  def sent_requests
    @transactions = Transaction.includes(:book, :seller)
                               .where(buyer: current_user)
                               .order(created_at: :desc)
  end

  # Creates a new transaction when a buyer sends a purchase request
  def create
    book = Book.find(params[:book_id])

    if book.status.downcase != "available"
      redirect_to book_path(book), alert: "This book is not available for purchase."
      return
    end

    existing_request = Transaction.find_by(
      book: book,
      buyer: current_user,
      status: "requested"
    )

    if existing_request
      redirect_to book_path(book), alert: "You've already requested to buy this book."
      return
    end

    Transaction.create!(
      book: book,
      buyer: current_user,
      seller: book.user,
      status: "requested",
      price: book.price
    )
    
    flash.discard(:alert)
    redirect_to sent_requests_transactions_path, notice: "Purchase request sent."
  end

  # Allows the seller to accept a purchase request; updates statuses accordingly
  def accept
    @transaction.update!(status: "confirmed")
    @transaction.book.update!(status: "reserved")

    # Reject all other requests for this book
    Transaction.where(book: @transaction.book, status: "requested")
               .where.not(id: @transaction.id)
               .update_all(status: "rejected")

    redirect_to received_requests_transactions_path, notice: "Request accepted. Other requests rejected."
  end

  # Marks a transaction as completed (buyer only), and updates the book status
  def complete
    @transaction = Transaction.find(params[:id])

    if @transaction.confirmed? && current_user == @transaction.seller
      @transaction.update!(status: "completed")
      @transaction.book.update!(status: "sold")

      redirect_to transactions_path, notice: "Transaction marked as completed."
    else
      redirect_to transactions_path, alert: "You are not authorized to complete this transaction."
    end
  end

  private

  # Sets the transaction object for accept actions
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
