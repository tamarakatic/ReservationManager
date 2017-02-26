class AddPriceToOfferItems < ActiveRecord::Migration[5.0]
  def change
    add_column :offer_items, :price, :decimal
  end
end
