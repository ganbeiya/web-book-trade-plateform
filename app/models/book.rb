
class Book < ApplicationRecord

  belongs_to :user

  belongs_to :category, optional: true
  has_many :wishlists, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :transactions, dependent: :restrict_with_error
  
  has_one_attached :image
  validates :title, :author, :price, :condition, :status, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :isbn, length: { is: 13 }, allow_blank: true
  
  scope :search_term, ->(term) {
    return if term.blank?
    pattern = "%#{term.downcase}%"
    where("LOWER(title) LIKE ? OR LOWER(author) LIKE ?", pattern, pattern)
  }
  scope :price_between, ->(min, max) { where(price: min..max) if min.present? && max.present? }
  scope :with_condition, ->(c) { where(condition: c) if c.present? }
  scope :with_status, ->(status) { where(status: status) }
  scope :with_isbn, ->(isbn) { where(isbn: isbn) }
  scope :with_category, ->(category_id) {
    where(category_id: category_id) if category_id.present?
  }
  
  after_update :notify_target_hit, if: -> { 
    saved_change_to_price? && 
    price_previously_was > price && 
    wishlists.where('target_price >= ?', price).exists? 
  }

  after_initialize :set_default_status, if: :new_record?

  private
  # Set default status to "available" if not specified
  def set_default_status
    self.status ||= "available"
  end
  # If the current book's price is equal to or lower than the target price the user set, then send a notification email
  def notify_target_hit
    old_price =  price_before_last_save
    new_price = price
    wishlists.where('target_price >= ?', new_price).find_each do |wishlist|
      # Call the target_price_hit_notification method in app/mailers/wishlist_mailer.rb
      # deliver-later: Take all the target books and return first, then send emails one by one
      WishlistMailer.target_price_hit_notification(wishlist.user, self, wishlist, old_price, new_price).deliver_now
    end
  end
end
