class AddFoodTypeToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :food_type, :integer
  end
end
