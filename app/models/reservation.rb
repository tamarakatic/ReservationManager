class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :customer

  has_many :reservation_invitations
  has_many :reserved_tables
  has_many :number_of_seats, :through => :reserved_tables

  alias_attribute :owner, :customer
  alias_attribute :invitations, :reservation_invitations
  alias_attribute :table, :number_of_seat

  validates :reserved_from, :presence => true,
                            :timeliness => { :on_or_after => lambda { Date.current }, :type => :date }

  validates :reserved_to, :presence => true,
                          :timeliness => { :on_or_after => lambda { Date.current }, :type => :date }

  validate :reservation_date

  private

  def reservation_date
    if reserved_to <= reserved_from
      errors.add(:reserved_to, "Reservation duration is invalid")
    end
  end
end
