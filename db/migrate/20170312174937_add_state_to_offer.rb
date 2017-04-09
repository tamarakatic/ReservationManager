class AddStateToOffer < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :offer_state, :integer
  end
end
