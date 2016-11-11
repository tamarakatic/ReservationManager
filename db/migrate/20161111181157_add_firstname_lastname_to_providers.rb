class AddFirstnameLastnameToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :firstname, :string
    add_column :providers, :lastname, :string
  end
end
