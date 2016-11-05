class AddRestaurantToSeats < ActiveRecord::Migration[5.0]
  def change
    add_reference :seats, :restaurant, foreign_key: true
  end
end
