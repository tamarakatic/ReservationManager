class ServingTime < ApplicationRecord

  belongs_to :employee
  belongs_to :customer_order

end
