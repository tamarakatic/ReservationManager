class CreateOfferItems < ActiveRecord::Migration[5.0]
  def change
    create_table :offer_items do |t|
      t.datetime :delivery_time

      t.timestamps
    end
  end
end
