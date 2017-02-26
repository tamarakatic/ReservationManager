class Profiles::EmployeeReonController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @restaurant = Restaurant.find(current_employee.manager_id)
  end
end
