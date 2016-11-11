class AddBirthDateToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :birth_date, :date
  end
end
