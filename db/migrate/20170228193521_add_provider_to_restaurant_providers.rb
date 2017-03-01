class AddProviderToRestaurantProviders < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurant_providers, :provider, foreign_key: true
  end
end
