class CustomerOrderPart < ApplicationRecord
  enum status: %w(Pending ProgressDrinks ProgressFoods ReadyFoods ReadyDrinks)

  belongs_to :customer_order
  belongs_to :employee

  has_many :customer_order_part_foods, :dependent => :destroy
  has_many :foods, :through => :customer_order_part_foods
  has_many :customer_order_part_drinks, :dependent => :destroy
  has_many :drinks, :through => :customer_order_part_drinks

  def delete_food(food)
    customer_order_part_foods.where(:food => food).delete_all
  end

  def update_food(food)
    customer_order_part_foods.create!(:food => food)
    touch(:updated_at)
  end

  def food_deleted?(food_ids)
    food_ids.count > foods.where(:id => food_ids).count
  end

  def delete_drink(drink)
    customer_order_part_drinks.where(:drink => drink).delete_all
  end

  def drink_deleted?(drink_ids)
    drink_ids.count > drinks.where(:id => drink_ids).count
  end
end
