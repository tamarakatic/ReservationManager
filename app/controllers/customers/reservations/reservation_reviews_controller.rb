class Customers::Reservations::ReservationReviewsController < ApplicationController
  require 'set'

  before_action :authenticate_customer!

  layout "home_page"

  # GET /reservation_reviews/1
  def index
    @reservation = Reservation.find(params[:reservation])
    @drinks = Set[]
    @foods = Set[]
    @waiters = Set[]
    @restHelper = false
    @foodHelper = false
    @drinkHelper = false
    customer_orders = @reservation.customer_orders.select{ |order| order.status == 'Finished' }

    customer_orders.each do |order|
      order.drinks.each do |drink|
        @drinks << drink
      end
      order.foods.each do |food|
        @foods << food
      end
      order.serving_times.each do |time|
        @waiters << Employee.find(time.employee_id)
      end
    end

    restaurant = Restaurant.find(@reservation.restaurant_id)
    temp = RestaurantReview.where(:customer_id => current_customer.id, :restaurant_id => restaurant.id).first
    unless temp.nil?
      @restHelper = true
    end

    temp = FoodReview.where(:customer_id => current_customer.id, :food_id => @foods.to_a[0]).first
    unless temp.nil?
      @foodHelper = true
    end

    temp = DrinkReview.where(:customer_id => current_customer.id, :drink_id => @drinks.to_a[0]).first
    unless temp.nil?
      @drinkHelper = true
    end

  end

  # POST /reservation_reviews/restaurant
  def restaurant_review
    review = Review.create(:rating => params[:id][:review])
    RestaurantReview.create(:restaurant_id => params[:id][:resId],
                            :review_id => review.id,
                            :customer_id => current_customer.id)

    respond_to do |format|
      format.html { redirect_to reservation_reviews_path(:reservation => params[:id][:reservationId]) }
    end
  end

  # POST /reservation_reviews/foods
  def foods_review
    review = Review.create(:rating => params[:id][:review])
    params[:id][:arr].each do |food|
      FoodReview.create(:food_id => food,
                        :review_id => review.id,
                        :customer_id => current_customer.id)

    end
    respond_to do |format|
      format.html { redirect_to reservation_reviews_path(:reservation => params[:id][:reservationId]) }
    end
  end

  # POST /reservation_reviews/drinks
  def drinks_review
    review = Review.create(:rating => params[:id][:review])
    params[:id][:arr].each do |drink|
      DrinkReview.create(:drink_id => drink,
                        :review_id => review.id,
                        :customer_id => current_customer.id)

    end
    respond_to do |format|
      format.html { redirect_to reservation_reviews_path(:reservation => params[:id][:reservationId]) }
    end
  end

  # POST /reservation_reviews/waiters
  def waiters_review
    review = Review.create(:rating => params[:id][:review])
    EmployeeReview.create(:employee_id => params[:id][:waiterId],
                          :review_id   => review.id,
                          :customer_id => current_customer.id)

    respond_to do |format|
      format.html { redirect_to reservation_reviews_path(:reservation => params[:id][:reservationId]) }
    end
  end


end
