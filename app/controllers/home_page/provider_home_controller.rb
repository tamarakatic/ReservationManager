class HomePage::ProviderHomeController < ApplicationController
  before_action :authenticate_provider!
  before_action :check_if_password_changed

  layout "restaurant_home"

  def index
    restaurant = RestaurantProvider.where(:provider_id => current_provider.id).map { |e| e.restaurant_id }
    @restaurants = Restaurant.find(restaurant)
  end

  private

  def check_if_password_changed
    unless current_provider.password_changed
      redirect_to edit_provider_registration_path(current_provider)
    end
  end

end
