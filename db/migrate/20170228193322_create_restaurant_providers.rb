class CreateRestaurantProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_providers do |t|

      t.timestamps
    end
  end
end
