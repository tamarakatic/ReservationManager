class CustomerOrder < ApplicationRecord

  enum status: %w(Active Pending ProgressDrinks ProgressFoods Progress ReadyFoods ReadyDrinks ProgressFoodsWithReadyDrinks ProgressDrinksWithReadyFoods Ready Finished)

  has_many :customer_order_foods, :dependent => :destroy
  has_many :foods, :through => :customer_order_foods
  has_many :customer_order_drinks, :dependent => :destroy
  has_many :drinks, :through => :customer_order_drinks
  has_one :customer_order_seat, :dependent => :destroy
  has_many :number_of_seats, :through => :customer_order_seat
  has_many :serving_times

end
