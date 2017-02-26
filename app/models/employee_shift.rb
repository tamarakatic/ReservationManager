class EmployeeShift < ApplicationRecord

  belongs_to :employee
  belongs_to :shift
  belongs_to :seat, optional: true

end
