class CreateDrinkReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :drink_reviews do |t|

      t.timestamps
    end
  end
end
