class AddColumnsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :active_from, :datetime
    add_column :orders, :active_till, :datetime
  end
end
