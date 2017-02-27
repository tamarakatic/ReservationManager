class AddRestaurantToReservation < ActiveRecord::Migration[5.0]
  def change
    add_reference :reservations, :restaurant, foreign_key: true
  end
end
