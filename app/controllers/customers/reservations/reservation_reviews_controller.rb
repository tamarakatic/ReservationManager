class Customers::Reservations::ReservationReviewsController < ApplicationController
  require 'set'

  before_action :authenticate_customer!

  def index
    @reservation = Reservation.find(params[:reservation])
    @drinks = Set[]
    @foods = Set[]
    customer_orders = @reservation.customer_orders
    customer_orders.each do |order|
      order.drinks.each do |drink|
        @drinks << drink
      end
      order.foods.each do |food|
        @foods << food
      end
    end
  end

  def restaurant_review
    review = Review.create(:rating => params[:id][:review])
    RestaurantReview.create(:restaurant_id => params[:id][:resId],
                            :review_id => review.id)

    respond_to do |format|
      format.html {redirect_to root_path}
    end
  end

  def foods_review
    review = Review.create(:rating => params[:id][:review])
    params[:id][:arr].each do |food|
      FoodReview.create(:food_id => food,
                        :review_id => review.id)

    end
    respond_to do |format|
      format.html { redirect_to root_path}
    end
  end

  def drinks_review
    review = Review.create(:rating => params[:id][:review])
    params[:id][:arr].each do |drink|
      DrinkReview.create(:drink_id => drink,
                        :review_id => review.id)

    end
    respond_to do |format|
      format.html { redirect_to root_path}
    end
  end


end
