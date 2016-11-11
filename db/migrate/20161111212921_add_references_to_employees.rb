class AddReferencesToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_reference :employees, :manager, foreign_key: true
  end
end
