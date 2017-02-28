module TableOrdersHelper

  def findCook(food, cooks)
    cookArray = []
    cooks.each do |cook|
      if food.food_type == cook.speciality
        cookArray << cook
      end
    end
    cookArray
  end

end
