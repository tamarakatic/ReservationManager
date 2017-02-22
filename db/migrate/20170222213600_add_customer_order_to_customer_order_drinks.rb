class AddCustomerOrderToCustomerOrderDrinks < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_drinks, :customer_order, foreign_key: true
  end
end
