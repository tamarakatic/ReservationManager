class CustomerOrderPartDrink < ApplicationRecord
  belongs_to :drink
  belongs_to :customer_order_part
end
