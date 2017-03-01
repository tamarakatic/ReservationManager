class AddCustomerOrderPartToCustomerOrderPartDrinks < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_part_drinks, :customer_order_part, foreign_key: true
  end
end
