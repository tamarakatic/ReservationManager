class AddRestaurantToRestaurantProviders < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurant_providers, :restaurant, foreign_key: true
  end
end
