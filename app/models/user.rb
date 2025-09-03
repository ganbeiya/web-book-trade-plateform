
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # One user can have multiple books in Wishlist; deleting user account also delete the user's wishlist.       
  has_many :wishlists, dependent: :destroy

  # A user can have multiple books; deleting the user also deletes their books
  has_many :books, dependent: :destroy

  # A user can send multiple messages; deleting the user also deletes the messages they sent
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy

  # A user can receive multiple messages; deleting the user also deletes the messages they received
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy

  # Reviews written by this user (as reviewer)
  has_many :written_reviews, class_name: "UserReview", foreign_key: :reviewer_id, dependent: :destroy

  # Reviews received by this user (as reviewee)
  has_many :received_reviews, class_name: "UserReview", foreign_key: :reviewee_id, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 6 , maximum: 15 }
end
