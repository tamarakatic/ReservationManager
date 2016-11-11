class AddFirstnameToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :firstname, :string
  end
end
