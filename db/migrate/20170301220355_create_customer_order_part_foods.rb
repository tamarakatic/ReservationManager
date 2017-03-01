class CreateCustomerOrderPartFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_order_part_foods do |t|

      t.timestamps
    end
  end
end
