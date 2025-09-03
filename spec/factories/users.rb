# File Created 7/27/2025 by Dokyung Lee
# This file contains the factory definition for User

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}abc" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
  end
end
