class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :customer

  has_many :reservation_invitations, :dependent => :destroy
  has_many :reserved_tables, :dependent => :destroy
  has_many :number_of_seats, :through => :reserved_tables

  has_many :reservation_orders
  has_many :customer_orders, :through => :reservation_orders, :dependent => :destroy

  alias_attribute :host, :customer
  alias_attribute :invitations, :reservation_invitations
  alias_attribute :tables, :number_of_seats

  before_destroy :check_reservation_date

  validates :reserved_from, :presence => true,
                            :timeliness => { :on_or_after => lambda { Date.current }, :type => :date }

  validates :reserved_to, :presence => true,
                          :timeliness => { :on_or_after => lambda { Date.current }, :type => :date }

  validate :reservation_date

  def active?
    reserved_from >= Time.now
  end

  def orders_for(customer)
    customer_orders.where(:customer => customer)
  end

  def duration_in_hours
    (reserved_to - reserved_from).round / 3600.0
  end

  private

  def reservation_date
    if reserved_to <= reserved_from
      errors.add(:reserved_to, "Reservation duration is invalid.")
    end

    if reserved_from < Time.now
      errors.add(:reserved_from, "Reservation date is invalid.")
    end
  end

  def check_reservation_date
    (reserved_from - Time.now).round / 60.0 > 30
  end

end
