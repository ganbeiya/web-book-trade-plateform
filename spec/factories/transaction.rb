# File created 7/27/2025 by Dokyung Lee
# This file contains the factory definition for Transaction

FactoryBot.define do
  factory :transaction do
    status { "pending" }
    association :book, factory: :book
    association :buyer, factory: :user
    association :seller, factory: :user
  end
end
