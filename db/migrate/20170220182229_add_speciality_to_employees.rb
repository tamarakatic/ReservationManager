class AddSpecialityToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :speciality, :string
  end
end
