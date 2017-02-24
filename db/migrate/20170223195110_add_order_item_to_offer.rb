class AddOrderItemToOffer < ActiveRecord::Migration[5.0]
  def change
    add_reference :offers, :order_item, foreign_key: true
  end
end
