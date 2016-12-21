class CreateJoinTableRestaurantProvider < ActiveRecord::Migration[5.0]
  def change
    create_join_table :restaurants, :providers do |t|
      t.index [:restaurant_id, :provider_id]
      # t.index [:provider_id, :restaurant_id]
    end
  end
end
