class Offer < ApplicationRecord
  belongs_to :provider
  belongs_to :order
  has_many :offer_item
end
