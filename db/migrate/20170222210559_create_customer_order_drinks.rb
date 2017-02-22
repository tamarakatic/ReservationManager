class CreateCustomerOrderDrinks < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_order_drinks do |t|

      t.timestamps
    end
  end
end
