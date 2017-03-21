class ReservationInvitation < ApplicationRecord
  belongs_to :reservation
  belongs_to :customer

  enum :status => [:pending, :accepted, :canceled, :declined]

  alias_attribute :guest, :customer

  after_create :send_email

  private

  def send_email
    ReservationMailer.invitation_email(self.customer, self.reservation).deliver_later
  end
end
