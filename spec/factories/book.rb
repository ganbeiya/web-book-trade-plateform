# File Created 7/27/2025 by Dokyung Lee
# This file contains the factory definition for Book

FactoryBot.define do
  factory :book do
    title { "Sample Book" }
    author { "Jane Doe" }
    isbn { "1234567890123" }
    price { 99.99 }
    condition { "Good" }
    association :user
  end
end
