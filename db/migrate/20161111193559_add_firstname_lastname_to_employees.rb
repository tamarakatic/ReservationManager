class AddFirstnameLastnameToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :firstname, :string
    add_column :employees, :lastname, :string
  end
end
