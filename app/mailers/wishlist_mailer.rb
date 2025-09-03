class WishlistMailer < ApplicationMailer
  default from: "no-reply@book2book.com"  

  # @params user: who receive the email
  #         book: the book which drops the price
  #         wishlist: a wishlist that contains target_price
  def target_price_hit_notification(user, book, wishlist, original_price, new_price)
    @user = user
    @book = book
    @original_price = original_price
    @current_price = new_price
    @target_price = wishlist.target_price

    #@most_popular_books = Book.top_sellers.limit(10)
    mail to: @user.email,
        subject: "🎉[Book2Book]Target price reached!"
  end
end
