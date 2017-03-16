class FoodReview < ApplicationRecord
  belongs_to :food
  belongs_to :review
  belongs_to :customer
end
