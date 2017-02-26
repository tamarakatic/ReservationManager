class RemoveDeliveryTimeFromOfferItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :offer_items, :delivery_time, :datetime
  end
end
