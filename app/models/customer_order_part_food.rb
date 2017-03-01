class CustomerOrderPartFood < ApplicationRecord
  belongs_to :food
  belongs_to :customer_order_part
end
