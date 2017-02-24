class AddSeatstableToNumberOfSeat < ActiveRecord::Migration[5.0]
  def change
    add_column :number_of_seats, :seatstable, :integer
  end
end
