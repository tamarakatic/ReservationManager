class AddCustomerToRestaurantReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurant_reviews, :customer, foreign_key: true
  end
end
