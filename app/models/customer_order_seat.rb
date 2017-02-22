class CustomerOrderSeat < ApplicationRecord
  belongs_to :customer_order
  belongs_to :seat
end
