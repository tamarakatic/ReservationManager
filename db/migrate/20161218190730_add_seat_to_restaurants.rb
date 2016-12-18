class AddSeatToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurants, :seat, foreign_key: true
  end
end
