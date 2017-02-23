class CreateCustomerOrderFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_order_foods do |t|

      t.timestamps
    end
  end
end
