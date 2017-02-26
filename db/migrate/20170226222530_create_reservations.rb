class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.datetime :reserved_from
      t.datetime :reserved_to

      t.timestamps
    end
  end
end
