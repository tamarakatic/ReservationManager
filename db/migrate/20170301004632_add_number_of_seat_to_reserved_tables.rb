class AddNumberOfSeatToReservedTables < ActiveRecord::Migration[5.0]
  def change
    add_reference :reserved_tables, :number_of_seat, foreign_key: true
  end
end
