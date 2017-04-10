class Food < ApplicationRecord
  belongs_to :restaurant
  has_many :customer_order_foods, :dependent => :destroy
  has_many :customer_orders, :through => :customer_order_foods

  has_many :food_reviews
  has_many :reviews, :through => :food_reviews

  has_many :customer_order_part_foods
  has_many :customer_order_parts, :through => :customer_order_part_foods

  enum food_type: %w(Desert Pasta Salad Appetizer Fish Soup RoastMeal CookedMeal)

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0.01 }

  validates :name, presence: true,
                   uniqueness: true,
                   length: { in: 2..30 },
                   allow_blank: false

  validates :description, presence: true,
                          length: { maximum: 300 },
                          allow_blank: false
end
