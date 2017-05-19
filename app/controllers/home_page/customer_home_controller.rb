class HomePage::CustomerHomeController < ApplicationController
  before_action :authenticate_customer!

  layout "customer_home"

  def index
    @filterrific = initialize_filterrific(
      Restaurant,
      filterrific_params,
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

    @distances = distances_for(@restaurants.map(&:title)) if request.xhr?

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /restaurant_distances
  def restaurant_distances
    render :json => distances_for(params[:restaurants])
  end

  private

  def distances_for(restaurant_titles)
    Restaurant.where(:title => restaurant_titles).each_with_object({}) do |restaurant, hash|
      hash[restaurant.id] = restaurant.distance_in_kms_from(user_location)
    end
  end

  def user_location
    return session[:location] if session[:location].present?

    if params[:latitude].present? && params[:longitude].present?
      session[:location] = [ params[:latitude], params[:longitude] ]
    end

    session[:location]
  end

  def filterrific_params
    return nil if params[:filterrific].nil?

    option = params[:filterrific][:sorted_by]

    params[:filterrific][:sorted_by] = {
      :option => option,
      :latitude => session[:location].first,
      :longitude => session[:location].second
    }

    params[:filterrific]
  end

end
