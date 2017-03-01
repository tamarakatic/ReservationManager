class AddRestaurantToRestaurantReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurant_reviews, :restaurant, foreign_key: true
  end
end
