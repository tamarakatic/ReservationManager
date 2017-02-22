class CustomerOrderDrink < ApplicationRecord
  belongs_to :customer_order
  belongs_to :drink
end
