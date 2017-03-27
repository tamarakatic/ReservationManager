class AddLocationToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :latitude, :decimal
    add_column :restaurants, :longitude, :decimal
  end
end
