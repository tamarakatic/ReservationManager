module Profiles::WaiterOrdersHelper
  def getPrice(order)
    total = 0
    order.foods.each do |food|
      total += food.price
    end
    order.drinks.each do |drink|
      total += drink.price
    end
    total
  end
end
