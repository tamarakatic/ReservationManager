class AddCustomerToFoodReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :food_reviews, :customer, foreign_key: true
  end
end
