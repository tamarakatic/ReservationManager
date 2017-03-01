class AddReservationToReservationInvitation < ActiveRecord::Migration[5.0]
  def change
    add_reference :reservation_invitations, :reservation, foreign_key: true
  end
end
