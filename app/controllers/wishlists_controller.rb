
class WishlistsController < ApplicationController
  # Ensure user is logged in
  before_action :authenticate_user!
  # Load current user's wishlist record for edit/update/destroy
  before_action :set_wishlist, only: [:edit, :update, :destroy]
  
  def index
    @wishlists = current_user.wishlists.includes(:book)
  end
  
  def new
    @wishlist = current_user.wishlists.new(book_id: params[:book_id])
  end

  def create
    book_id = params[:wishlist][:book_id]

    if current_user.wishlists.exists?(book_id: book_id)
      redirect_to book_path(book_id), alert: "This book is already in your wishlist."
      return
    end

    @wishlist = current_user.wishlists.new(wishlist_params)

    if @wishlist.save
      redirect_to book_path(book_id), notice: "Book added to wishlist."
    else
      redirect_to book_path(book_id), alert: "Failed to add to wishlist."
    end
  end

  
  def edit; end
  
  def update
    if @wishlist.update(wishlist_params)
    redirect_to wishlists_path, notice: "Wishlist item updated."
    else
    render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @wishlist.destroy
    redirect_to wishlists_path, notice: "Wishlist item was successfully deleted."
  end
  
  

  private

  # Find wishlist belonging to current user
  def set_wishlist
    @wishlist = current_user.wishlists.find(params[:id])
  end

  # Permit allowed form parameters
  def wishlist_params
    params.require(:wishlist).permit(:book_id, :note, :target_price)
  end
end
