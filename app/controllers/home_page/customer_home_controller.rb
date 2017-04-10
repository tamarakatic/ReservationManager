class HomePage::CustomerHomeController < ApplicationController
  before_action :authenticate_customer!

  layout "customer_home"

  def index
    @filterrific = initialize_filterrific(
      Restaurant,
      params[:filterrific],
      :select_options => {
        :sorted_by => Restaurant.sort_options
      }
    ) or return

    @restaurants = @filterrific.find

    @markers = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat   restaurant.latitude
      marker.lng   restaurant.longitude
      marker.title restaurant.title
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /restaurant_distances
  def restaurant_distances
    restaurants = Restaurant.where(:title => params[:restaurants])

    distances = restaurants.each_with_object({}) do |restaurant, hash|
      hash[restaurant.id] = restaurant.distance_in_kms_from(user_location)
    end

    render :json => distances
  end

  private

  def user_location
    [ params[:latitude], params[:longitude] ]
  end

end
