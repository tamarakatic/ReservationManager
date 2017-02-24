class AddRestaurantToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :restaurant, foreign_key: true
  end
end
