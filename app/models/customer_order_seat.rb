class CustomerOrderSeat < ApplicationRecord
  belongs_to :customer_order
  belongs_to :number_of_seat
end
