class AddReviewToEmployeeReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :employee_reviews, :review, foreign_key: true
  end
end
