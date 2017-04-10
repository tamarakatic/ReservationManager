class Review < ApplicationRecord

  has_many :restaurant_reviews
  has_many :restaurants, :through => :restaurant_reviews
  has_many :food_reviews
  has_many :foods, :through => :food_reviews
  has_many :drink_reviews
  has_many :drinks, :through => :drink_reviews
  has_many :employee_reviews
  has_many :employees, :through => :employee_reviews

  validates :rating, numericality: { less_then_or_equal_to: 5, only_integer: true,
                                     greater_than_or_equal_to: 1}

end
