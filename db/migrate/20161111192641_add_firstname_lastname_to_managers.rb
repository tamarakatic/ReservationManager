class AddFirstnameLastnameToManagers < ActiveRecord::Migration[5.0]
  def change
    add_column :managers, :firstname, :string
    add_column :managers, :lastname, :string
  end
end
