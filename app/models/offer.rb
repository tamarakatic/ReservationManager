class Offer < ApplicationRecord
  belongs_to :provider
  belongs_to :order_item
end
