# Preview all emails at http://localhost:3000/rails/mailers/wishlist_mailer
class WishlistMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/wishlist_mailer/price_drop_notification
  def price_drop_notification
    WishlistMailer.price_drop_notification
  end

end
