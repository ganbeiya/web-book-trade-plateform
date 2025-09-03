
class UserReviewsController < ApplicationController
  before_action :authenticate_user!

  # Displays a form for creating a new user review
  def new
    @transaction = Transaction.find(params[:book_transaction_id])
    @reviewee = @transaction.buyer == current_user ? @transaction.seller : @transaction.buyer

    @user_review = UserReview.new(
      book_transaction_id: @transaction.id,
      reviewee_id: @reviewee.id
    )
  end

  # Handles the creation of a new user review
  def create
    @user_review = UserReview.new(user_review_params)
    @user_review.reviewer = current_user
    transaction = Transaction.find(@user_review.book_transaction_id)
    @user_review.book_id = transaction.book_id

    if @user_review.save
      redirect_to transactions_path, notice: "Review submitted!"
    else
      flash.now[:alert] = "Failed to submit review."
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Permits only the allowed parameters for a user review
  def user_review_params
    params.require(:user_review).permit(:reviewee_id, :rating, :content, :book_transaction_id)
  end
end
