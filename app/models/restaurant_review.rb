class RestaurantReview < ApplicationRecord
  belongs_to :restaurant
  belongs_to :review
  belongs_to :customer
end
