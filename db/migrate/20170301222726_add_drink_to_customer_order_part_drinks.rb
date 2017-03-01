class AddDrinkToCustomerOrderPartDrinks < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_part_drinks, :drink, foreign_key: true
  end
end
