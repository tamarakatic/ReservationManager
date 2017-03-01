class AddFoodToFoodReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :food_reviews, :food, foreign_key: true
  end
end
