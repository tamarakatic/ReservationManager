class CreateCustomerOrderSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_order_seats do |t|

      t.timestamps
    end
  end
end
