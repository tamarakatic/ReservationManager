class Seat < ApplicationRecord
  belongs_to :restaurant

  validates :number, presence: true,
                     uniqueness: true,
                     numericality: { greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 100,
                                     only_integer: true }

  validates :area, presence: true,
                   allow_blank: false,
                   length: { in: 2..30 }
end
