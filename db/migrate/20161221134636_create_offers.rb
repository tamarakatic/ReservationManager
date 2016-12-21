class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :provider_id
      t.integer :restaurant_id
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
