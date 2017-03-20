class CustomerOrder < ApplicationRecord
  enum status: %w(Active Pending ProgressDrinks ProgressFoods Progress ReadyFoods ReadyDrinks Ready Finished)

  has_many :customer_order_foods, :dependent => :destroy
  has_many :customer_order_drinks, :dependent => :destroy
  has_many :customer_order_seats, :dependent => :destroy

  has_many :foods,  :through => :customer_order_foods
  has_many :drinks, :through => :customer_order_drinks
  has_many :number_of_seats, :through => :customer_order_seats

  has_many :serving_times, :dependent => :destroy
  has_many :customer_order_parts, :dependent => :destroy

  has_many :reservation_orders, :dependent => :destroy
  has_many :reservations, :through => :reservation_orders

  belongs_to :customer, :optional => true
end
