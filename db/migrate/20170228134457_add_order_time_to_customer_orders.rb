class AddOrderTimeToCustomerOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_orders, :order_time, :datetime
  end
end
