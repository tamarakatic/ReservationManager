class AddFoodToCustomerOrderPartFoods < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_part_foods, :food, foreign_key: true
  end
end
