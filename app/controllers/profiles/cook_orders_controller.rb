class Profiles::CookOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @customer_order = CustomerOrder.all
  end
end
