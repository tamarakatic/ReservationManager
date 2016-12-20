class AddPasswordChangedToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :password_changed, :boolean, default: false
  end
end
