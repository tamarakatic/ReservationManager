class AddDrinkToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurants, :drink, foreign_key: true
  end
end
