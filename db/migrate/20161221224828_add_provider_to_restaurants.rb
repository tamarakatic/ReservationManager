class AddProviderToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurants, :provider, foreign_key: true
  end
end
