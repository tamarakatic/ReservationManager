class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :offers
  has_many :order_items
end
