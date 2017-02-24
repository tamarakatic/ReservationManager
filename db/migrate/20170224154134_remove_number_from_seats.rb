class RemoveNumberFromSeats < ActiveRecord::Migration[5.0]
  def change
    remove_column :seats, :number, :integer
  end
end
