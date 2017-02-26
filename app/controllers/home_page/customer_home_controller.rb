class HomePage::CustomerHomeController < ApplicationController
  before_action :authenticate_customer!

  layout "customer_home"

  def index
    @restaurants = Restaurant.all
  end

end
