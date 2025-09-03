require "test_helper"

class WishlistMailerTest < ActionMailer::TestCase
  test "price_drop_notification delivers to correct user" do
    wishlist = wishlists(:one)
    book = books(:one)
    mail = WishlistMailer.price_drop_notification(wishlist.user, book, wishlist)

    assert_emails 1 do
      email.deliver_now
    end
    
    assert_equal "dropped", mail.subject
    assert_equal [wishlist.user.email], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
