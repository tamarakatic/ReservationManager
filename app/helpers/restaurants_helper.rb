module RestaurantsHelper

  def managers_information
    @managers.reject { |m| !m.confirmed? }.collect { |m| ["#{m.firstname} #{m.lastname}", m.id] }
  end

  def render_stars(value)
    output = ''
    if (1..5).include?(value.to_i)
      value.to_i.times { output += '*'}
    end
    output
  end

  def restaurant_income
    rand(1..10) * 1000
  end

  def render_food_stars(food_id)
    food_review = Review.find(FoodReview.where(:food_id => food_id).map {|e| e.food_id })
    @food_reviews = food_review.collect(&:rating).sum.to_f/food_review.length if food_review.length > 0
  end

  def render_waiter_stars(waiter_id)
    waiter_review = Review.find(EmployeeReview.where(:employee_id => waiter_id).map {|e| e.employee_id })
    @waiter_reviews = waiter_review.collect(&:rating).sum.to_f/waiter_review.length if waiter_review.length > 0
  end

  def employee_income(restaurant_id)
    Food.where(:restaurant_id => restaurant_id).map(&:price).inject(0, &:+).to_i +
    Drink.where(:restaurant_id => restaurant_id).map(&:price).inject(0, &:+).to_i
  end

end
