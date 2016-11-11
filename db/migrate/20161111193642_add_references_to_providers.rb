class AddReferencesToProviders < ActiveRecord::Migration[5.0]
  def change
    add_reference :providers, :manager, foreign_key: true
  end
end
