class AddReviewToRestaurantReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurant_reviews, :review, foreign_key: true
  end
end
