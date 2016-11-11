class AddClothingSizeToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :clothing_size, :integer
  end
end
