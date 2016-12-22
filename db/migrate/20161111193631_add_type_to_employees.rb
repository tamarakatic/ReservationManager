class AddTypeToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :type, :string
  end
end
