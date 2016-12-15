class AddManagerRefToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurants, :manager, foreign_key: true
  end
end
