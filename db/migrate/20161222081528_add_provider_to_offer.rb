class AddProviderToOffer < ActiveRecord::Migration[5.0]
  def change
    add_reference :offers, :provider, foreign_key: true
  end
end
