class AddReviewToDrinkReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :drink_reviews, :review, foreign_key: true
  end
end
