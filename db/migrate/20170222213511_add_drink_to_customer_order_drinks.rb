class AddDrinkToCustomerOrderDrinks < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_drinks, :drink, foreign_key: true
  end
end
