class Restaurant < ApplicationRecord
  belongs_to :manager
  has_many :foods, dependent: :destroy
  has_many :drinks, dependent: :destroy
  has_many :seats, dependent: :destroy
  has_many :restaurant_providers
  has_many :providers, :through => :restaurant_providers
  has_many :orders
  has_many :restaurant_reviews
  has_many :reviews, :through => :restaurant_reviews
  has_many :reservations
  has_many :tables, :through => :seats, :source => :number_of_seats

  validates :title, uniqueness: true,
                    length: { in: 2..30 },
                    presence: true,
                    allow_blank: false

  validates :description, length: { maximum: 300 },
                          presence: true,
                          allow_blank: false
end
