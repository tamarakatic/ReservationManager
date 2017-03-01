class AddDrinkToDrinkReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :drink_reviews, :drink, foreign_key: true
  end
end
