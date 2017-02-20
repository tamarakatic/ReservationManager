class Offer < ApplicationRecord
  belongs_to :provider
  belongs_to :order
end
