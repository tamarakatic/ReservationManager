class AddCustomerToEmployeeReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :employee_reviews, :customer, foreign_key: true
  end
end
