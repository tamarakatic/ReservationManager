class Restaurant < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :drinks, dependent: :destroy
  has_many :seats, dependent: :destroy
  has_many :offers
  has_many :providers, through: :offers
  belongs_to :manager

  validates :title, uniqueness: true,
                    length: { in: 2..30 },
                    presence: true,
                    allow_blank: false

  validates :description, length: { maximum: 300 },
                          presence: true,
                          allow_blank: false
end
