class AddStatusToCustomerOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_orders, :status, :integer
  end
end
