class AddShiftToEmployeeShifts < ActiveRecord::Migration[5.0]
  def change
    add_reference :employee_shifts, :shift, foreign_key: true
  end
end
