class Profiles::EmployeeReonController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @restaurant = Restaurant.find(current_employee.manager_id)
    employee_shift = EmployeeShift.where(:employee_id => current_employee.id)
    @arrDates = []
    employee_shift.each do |esh|
      @arrDates << Shift.find(esh.shift_id)
    end
  end

  def seats
    date = params[:id]
    employee_shift = EmployeeShift.where(:employee_id => current_employee.id)
    @arrDates = []
    employee_shift.each do |esh|
      @arrDates << Shift.find(esh.shift_id)
    end
    @arrDates.each do |shift|
      if(shift.work_day.iso8601 == date)
        employee = EmployeeShift.where(:employee_id => current_employee, :shift_id => shift.id).first
        @seat = Seat.find(employee.seat_id)
        respond_to do |format|
          if request.xhr?
            format.json { render :json => {:seat => @seat,
                                           :employee => current_employee } }
          else
            format.html
          end
        end
      end
    end
  end
end
