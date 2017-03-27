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
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.title restaurant.title
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

end
