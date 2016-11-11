class AddLastnameToSystemManagers < ActiveRecord::Migration[5.0]
  def change
    add_column :system_managers, :lastname, :string
  end
end
