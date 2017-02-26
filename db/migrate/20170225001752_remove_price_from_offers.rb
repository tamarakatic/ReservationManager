class RemovePriceFromOffers < ActiveRecord::Migration[5.0]
  def change
    remove_column :offers, :price, :decimal
  end
end
