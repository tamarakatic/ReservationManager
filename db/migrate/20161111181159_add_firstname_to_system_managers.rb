class AddFirstnameToSystemManagers < ActiveRecord::Migration[5.0]
  def change
    add_column :system_managers, :firstname, :string
  end
end
