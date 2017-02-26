class CreateEmployeeShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_shifts do |t|

      t.timestamps
    end
  end
end
