class AddCustomerOrderToCustomerOrderSeats < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_seats, :customer_order, foreign_key: true
  end
end
