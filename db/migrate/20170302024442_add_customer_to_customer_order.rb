class AddCustomerToCustomerOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_orders, :customer, foreign_key: true
  end
end
