class NumberOfSeat < ApplicationRecord
  belongs_to :seat
  has_many :reserved_tables
  has_many :reservations, :through => :reserved_tables

  has_many :customer_order_seats, :dependent => :destroy
  has_many :customer_orders, :through => :customer_order_seats

  validates :number, presence: true,
                     uniqueness: true,
                     numericality: { greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 100,
                                     only_integer: true }

  validates :seatstable, presence: true,
                         numericality: { greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 20,
                                         only_integer: true }

  def reserved?(start_date, end_date)
    self.reservations.any? do |reservation|
      interval_overlaps?(reservation.reserved_from,
                         reservation.reserved_to,
                         start_date,
                         end_date)
    end
  end

  private

  def interval_overlaps?(first_start, first_end, second_start, second_end)
    (first_start - second_end) * (second_start - first_end) >= 0
  end

end
