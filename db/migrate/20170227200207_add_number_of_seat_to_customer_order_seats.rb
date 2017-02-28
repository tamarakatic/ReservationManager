class AddNumberOfSeatToCustomerOrderSeats < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_seats, :number_of_seat, foreign_key: true
  end
end
