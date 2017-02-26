class AddSeatToEmployeeShifts < ActiveRecord::Migration[5.0]
  def change
    add_reference :employee_shifts, :seat, foreign_key: true
  end
end
