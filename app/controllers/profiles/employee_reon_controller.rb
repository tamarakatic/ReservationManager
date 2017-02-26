class Profiles::EmployeeReonController < ApplicationController

  layout "home_page"

  def index
    @restaurant = Restaurant.where(:manager_id => current_employee.manager_id).first
  end
end
