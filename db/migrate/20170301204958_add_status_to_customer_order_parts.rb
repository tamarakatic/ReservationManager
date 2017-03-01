class AddStatusToCustomerOrderParts < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_order_parts, :status, :integer
  end
end
