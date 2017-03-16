class CustomerOrderPart < ApplicationRecord

  enum status: %w(Pending ProgressDrinks ProgressFoods ReadyFoods ReadyDrinks)

  belongs_to :customer_order
  belongs_to :employee
  has_many :customer_order_part_foods
  has_many :foods, :through => :customer_order_part_foods
  has_many :customer_order_part_drinks
  has_many :drinks, :through => :customer_order_part_drinks
end
