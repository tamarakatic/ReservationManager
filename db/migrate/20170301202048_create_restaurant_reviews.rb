class CreateRestaurantReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_reviews do |t|

      t.timestamps
    end
  end
end
