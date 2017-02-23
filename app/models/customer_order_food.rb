class CustomerOrderFood < ApplicationRecord
  belongs_to :food
  belongs_to :customer_order
end
