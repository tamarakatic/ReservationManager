class CreateFoodReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :food_reviews do |t|

      t.timestamps
    end
  end
end
