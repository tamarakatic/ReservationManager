class DrinkReview < ApplicationRecord
  belongs_to :drink
  belongs_to :review
  belongs_to :customer
end
