class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.string :item
      t.decimal :quantity
      t.string :unit_of_measure

      t.timestamps
    end
  end
end
