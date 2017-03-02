class CustomerOrder < ApplicationRecord
  enum status: %w(Active Pending ProgressDrinks ProgressFoods Progress ReadyFoods ReadyDrinks ProgressFoodsWithReadyDrinks ProgressDrinksWithReadyFoods Ready Finished)

  has_many :customer_order_foods
  has_many :customer_order_drinks
  has_many :customer_order_seats
  has_many :foods,  :through => :customer_order_foods
  has_many :drinks, :through => :customer_order_drinks
  has_many :number_of_seats, :through => :customer_order_seats
  has_many :serving_times
  has_many :customer_order_parts

  has_many :reservation_orders
  has_many :reservations, :through => :reservation_orders

  belongs_to :customer, :optional => true
end
