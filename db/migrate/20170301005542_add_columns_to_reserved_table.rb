class AddColumnsToReservedTable < ActiveRecord::Migration[5.0]
  def change
    add_column :reserved_tables, :date, :datetime
    add_column :reserved_tables, :duration, :decimal, precision: 3, scale: 1
  end
end
