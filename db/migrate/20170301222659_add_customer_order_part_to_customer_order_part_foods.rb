class AddCustomerOrderPartToCustomerOrderPartFoods < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_part_foods, :customer_order_part, foreign_key: true
  end
end
