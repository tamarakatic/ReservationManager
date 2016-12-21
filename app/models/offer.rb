class Offer < ApplicationRecord
  belongs_to :restaurant
  belongs_to :provider

  validates :start_at, presence: true,
                       allow_blank: false
                       
  validates :end_at, presence: true,
                      allow_blank: false

end
