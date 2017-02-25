class AddEmployeeToEmployeeShifts < ActiveRecord::Migration[5.0]
  def change
    add_reference :employee_shifts, :employee, foreign_key: true
  end
end
