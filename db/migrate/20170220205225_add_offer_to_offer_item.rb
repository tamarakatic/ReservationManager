class AddOfferToOfferItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :offer_items, :offer, foreign_key: true
  end
end
