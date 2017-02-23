class HomePage::EmployeeHomeController < ApplicationController
  before_action :authenticate_employee!
  before_action :check_whether_password_changed

  layout "home_page"

  def index
    @restauran = Restaurant.where(manager_id: current_employee.manager_id).first
  end

  private

  def check_whether_password_changed
    # Force employee to change auto-generated password
    unless current_employee.password_changed
      redirect_to edit_employee_registration_path(current_employee)
    end
  end

end
