class CustomerOrder < ApplicationRecord
  has_many :customer_order_foods, :dependent => :destroy
  has_many :foods, :through => :customer_order_foods
  has_many :customer_order_drinks, :dependent => :destroy
  has_many :drinks, :through => :customer_order_drinks
  has_many :customer_order_seats, :dependent => :destroy
  has_many :seats, :through => :customer_order_seats

end
