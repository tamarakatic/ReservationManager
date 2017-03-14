class AddCustomerToDrinkReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :drink_reviews, :customer, foreign_key: true
  end
end
