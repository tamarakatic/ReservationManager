class AddFoodToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurants, :food, foreign_key: true
  end
end
