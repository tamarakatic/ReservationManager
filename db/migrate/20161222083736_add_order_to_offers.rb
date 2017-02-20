class AddOrderToOffers < ActiveRecord::Migration[5.0]
  def change
    add_reference :offers, :order, foreign_key: true
  end
end
