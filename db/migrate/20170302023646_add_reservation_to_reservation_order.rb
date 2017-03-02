class AddReservationToReservationOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :reservation_orders, :reservation, foreign_key: true
  end
end
