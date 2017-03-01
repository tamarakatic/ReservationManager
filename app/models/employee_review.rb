class EmployeeReview < ApplicationRecord
  belongs_to :employee
  belongs_to :review
end
