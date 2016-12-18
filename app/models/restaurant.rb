class Restaurant < ApplicationRecord
  belongs_to :food
  belongs_to :drink
  belongs_to :seat
  belongs_to :manager

  validates :title, uniqueness: true,
                    length: { in: 2..30 },
                    presence: true,
                    allow_blank: false

  validates :description, length: { maximum: 300 },
                          presence: true,
                          allow_blank: false
end
