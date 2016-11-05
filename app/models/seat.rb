class Seat < ApplicationRecord
  belongs_to :restaurant

  validates :number, :area, presence: true
  validates :number,
    uniqueness: true,
    numericality: { greater_than_or_equal_to: 1,
                    less_than_or_equal_to: 100 }
  validates :area, length: { in: 2..30 }
end
