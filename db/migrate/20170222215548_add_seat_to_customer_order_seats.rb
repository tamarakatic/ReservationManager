class AddSeatToCustomerOrderSeats < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_seats, :seat, foreign_key: true
  end
end
