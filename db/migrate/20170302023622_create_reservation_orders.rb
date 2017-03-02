class CreateReservationOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :reservation_orders do |t|

      t.timestamps
    end
  end
end
