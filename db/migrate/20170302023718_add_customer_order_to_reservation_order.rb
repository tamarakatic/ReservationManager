class AddCustomerOrderToReservationOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :reservation_orders, :customer_order, foreign_key: true
  end
end
