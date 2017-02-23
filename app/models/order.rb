class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :offers
  has_many :order_items

  accepts_nested_attributes_for :order_items, :reject_if => :all_blank,
                                              :allow_destroy => true
end
