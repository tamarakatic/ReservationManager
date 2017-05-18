class CustomerOrder < ApplicationRecord
  enum status: %w(Active Pending ProgressDrinks ProgressFoods Progress ReadyFoods ReadyDrinks Ready Finished)

  has_many :customer_order_foods, :dependent => :destroy
  has_many :customer_order_drinks, :dependent => :destroy
  has_many :customer_order_seats, :dependent => :destroy

  has_many :foods,  :through => :customer_order_foods
  has_many :drinks, :through => :customer_order_drinks
  has_many :number_of_seats, :through => :customer_order_seats

  has_many :serving_times, :dependent => :destroy
  has_many :customer_order_parts, :dependent => :destroy

  has_many :reservation_orders, :dependent => :destroy
  has_many :reservations, :through => :reservation_orders

  belongs_to :customer, :optional => true

  def any_orders_left?
    customer_order_foods.exists? or customer_order_drinks.exists?
  end

  def delete_food_order(food)
    @food = food

    if order_part.nil?
      delete_food(food)
    else
      order_part.with_lock("FOR SHARE") do
        debugger
        delete_food(food) if order_part.status == "Pending"
      end
    end
  end

  def exchange_food_order(food, new_food)
    @food = food

    if order_part.nil?
      update_food(food, new_food)
    else
      order_part.with_lock("FOR SHARE") do
        sleep 10

        update_food(food, new_food) if order_part.status == "Pending"
      end
    end
  end

  private

  def delete_food(food)
    customer_order_foods.where(:food => food, :customer_order_id => id).delete_all
    order_part.delete_food(food)
  end

  def update_food(food, new_food)
    # food_order = customer_order_foods.where(:food => food, :customer_order_id => id).first
    # food_order.food = new_food
    # food_order.save!

    delete_food(food)
    customer_order_foods.create!(:food => new_food)
    order_part.update_food(new_food)
  end

  def order_part
    @order_part ||= CustomerOrderPart.joins(:customer_order_part_foods)
                                     .where(:customer_order_part_foods => { :food_id => @food.id },
                                            :customer_order_id => id)
                                     .first
  end
end
