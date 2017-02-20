class AddOfferItemToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :order_items, :offer_item, foreign_key: true
  end
end
