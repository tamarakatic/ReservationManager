class Customers::FriendsController < ApplicationController
  before_action :authenticate_customer!

  layout "home_page"

  def index
    @friends = current_customer.friends
  end
end
