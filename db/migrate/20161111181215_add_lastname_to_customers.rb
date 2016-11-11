class AddLastnameToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :lastname, :string
  end
end
