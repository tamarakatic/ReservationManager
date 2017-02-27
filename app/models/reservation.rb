class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :customer

  alias_attribute :owner, :customer

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
