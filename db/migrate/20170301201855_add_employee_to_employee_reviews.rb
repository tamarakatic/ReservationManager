class AddEmployeeToEmployeeReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :employee_reviews, :employee, foreign_key: true
  end
end
