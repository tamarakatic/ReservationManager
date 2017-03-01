class AddCustomerToReservationInvitation < ActiveRecord::Migration[5.0]
  def change
    add_reference :reservation_invitations, :customer, foreign_key: true
  end
end
