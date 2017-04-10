class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  layout 'restaurant_home'

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @managers = Manager.all
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  def list_food
    respond_to do |format|
      format.html { render :foods }
    end
  end

  def list_drink
    respond_to do |format|
      format.html { render :drinks }
    end
  end

  def list_seat
    respond_to do |format|
      format.html { render :seats }
    end
  end

  def visit_chart
    respond_to do |format|
      format.html { render :charts }
    end
  end

  def review_mark
    restaurant_review = Review.find(RestaurantReview.where(:restaurant_id => current_manager.restaurant.id).map {|e| e.restaurant_id })
    @restaurant_reviews = restaurant_review.collect(&:rating).sum.to_f/restaurant_review.length if restaurant_review.length > 0

    @foods = Food.where(:restaurant_id => current_manager.restaurant.id)

    @waiters = Employee.where(:manager_id => current_manager.id, :type => "Waiter")

    respond_to do |format|
      format.html { render :marks }
    end
  end

  def income
    respond_to do |format|
      format.html { render :incomes }
    end
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { render :edit, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:title, :description, :manager_id)
    end
end
