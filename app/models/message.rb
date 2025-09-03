
class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :book

  validates :content, presence: true, 
            length: {maximum: 200}
end
