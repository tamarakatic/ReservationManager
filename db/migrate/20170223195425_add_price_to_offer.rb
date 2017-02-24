class AddPriceToOffer < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :price, :decimal
  end
end
