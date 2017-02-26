class Profiles::EmployeeCalendarController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
  end

end
