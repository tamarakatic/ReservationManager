class ReservationInvitation < ApplicationRecord
  belongs_to :reservation
  belongs_to :customer

  enum :status => [:pending, :accepted, :canceled, :declined]
end
