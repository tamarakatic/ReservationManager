class CreateCustomerOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_orders do |t|

      t.timestamps
    end
  end
end
