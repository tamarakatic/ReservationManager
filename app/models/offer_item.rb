class OfferItem < ApplicationRecord
  has_one :order_item
  belongs_to :offer

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0.01 }

end
