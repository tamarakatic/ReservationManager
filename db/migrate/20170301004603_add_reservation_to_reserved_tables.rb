class AddReservationToReservedTables < ActiveRecord::Migration[5.0]
  def change
    add_reference :reserved_tables, :reservation, foreign_key: true
  end
end
