
class BooksController < ApplicationController
   # Added before_action :authenticate_user! to restrict access to show, selling and new actions for unauthenticated users
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy, :selling, :new]

  def index
    @categories = Category.order(:name)
    # take all possible parameter for show
    q, min, max, cond, stat, isbn, category_id = params.values_at(:q, :min_price, :max_price, :condition, :status, :isbn, :category_id)

    books = Book.all
    books = books.search_term(q)               if q.present?
    books = books.price_between(min, max)      if min.present? && max.present?
    books = books.with_condition(cond)         if cond.present?
    books = books.with_status(stat)            if stat.present?
    books = books.with_isbn(isbn)              if isbn.present?
    books = books.with_category(category_id)   if category_id.present?
    @books = books
               .order(created_at: :desc)
               .page(params[:page])
               .per(20)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to @book
    else
      puts @book.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    old_price = @book.price
    if @book.update(book_params)
      if @book.saved_change_to_price?
        new_price = @book.price
        hit_wishlists = @book.wishlists.where("target_price >= ?", new_price)
        if hit_wishlists.any?
          hit_wishlists.find_each do |wishlist|
            WishlistMailer.target_price_hit_notification(wishlist.user, @book, wishlist, old_price, new_price)
            .deliver_now
          end
          flash[:notice] = "The price-drop emails sent successfully to other users."
        end
      end
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @book.transactions.where.not(status: "requested").exists?
      redirect_to @book, alert: "Cannot delete this book because it has associated transactions."
    else
      @book.destroy
      redirect_to books_path, notice: "Book deleted successfully."
    end
  end
  
  def selling
    @books = current_user.books
    render :selling
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :price, :condition, :isbn, :image, :category_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def authorize_user!
    unless @book.user_id == current_user.id
      redirect_to books_path, alert: "You are not authorized to modify this book."
    end
  end
end
