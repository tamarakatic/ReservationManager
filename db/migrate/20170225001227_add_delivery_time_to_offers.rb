class AddDeliveryTimeToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :delivery_time, :datetime
  end
end
