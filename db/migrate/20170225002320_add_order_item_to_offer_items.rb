class AddOrderItemToOfferItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :offer_items, :order_item, foreign_key: true
  end
end
