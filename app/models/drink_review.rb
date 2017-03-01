class DrinkReview < ApplicationRecord
  belongs_to :drink
  belongs_to :review
end
