class AddRestaurantToFood < ActiveRecord::Migration[5.0]
  def change
    add_reference :foods, :restaurant, foreign_key: true
  end
end
