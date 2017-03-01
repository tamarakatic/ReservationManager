class AddCustomerOrderToServingTimes < ActiveRecord::Migration[5.0]
  def change
    add_reference :serving_times, :customer_order, foreign_key: true
  end
end
