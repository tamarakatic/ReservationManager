class NumberOfSeat < ApplicationRecord
  belongs_to :seat

  validates :number, presence: true,
                     uniqueness: true,
                     numericality: { greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 100,
                                     only_integer: true }

  validates :seatstable, presence: true,
                         numericality: { greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 20,
                                         only_integer: true }
end
