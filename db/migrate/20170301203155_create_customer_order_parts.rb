class CreateCustomerOrderParts < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_order_parts do |t|

      t.timestamps
    end
  end
end
