class AddEmployeeToCustomerOrderParts < ActiveRecord::Migration[5.0]
  def change
    add_reference :customer_order_parts, :employee, foreign_key: true
  end
end
