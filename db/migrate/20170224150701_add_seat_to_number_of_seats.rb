class AddSeatToNumberOfSeats < ActiveRecord::Migration[5.0]
  def change
    add_reference :number_of_seats, :seat, foreign_key: true
  end
end
