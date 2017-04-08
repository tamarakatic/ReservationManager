class OfferItem < ApplicationRecord
  belongs_to :offer
  belongs_to :order_item

  validates :price, :presence => true,
                    :numericality => { :greater_than_or_equal_to => 0 }
end
