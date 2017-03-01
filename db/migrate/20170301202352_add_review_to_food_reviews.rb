class AddReviewToFoodReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :food_reviews, :review, foreign_key: true
  end
end
