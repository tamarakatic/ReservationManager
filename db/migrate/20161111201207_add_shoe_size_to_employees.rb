class AddShoeSizeToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :shoe_size, :float
  end
end
