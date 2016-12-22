class AddRestaurantToProviders < ActiveRecord::Migration[5.0]
  def change
    add_reference :providers, :restaurant, foreign_key: true
  end
end
