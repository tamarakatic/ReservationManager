class AddEmployeeToServingTimes < ActiveRecord::Migration[5.0]
  def change
    add_reference :serving_times, :employee, foreign_key: true
  end
end
