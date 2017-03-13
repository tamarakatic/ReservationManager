class AddOrderActiveToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_active, :boolean
  end
end
