class Profiles::EmployeeCalendarController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @employee_shifts = EmployeeShift.all
    all_shifts = []

    @employee_shifts.each do |iterator|
      if(iterator.employee_id == current_employee.id)
        shift = Shift.find(iterator.shift_id)
        all_shifts << shift
      end
    end

    respond_to do |format|
      if request.xhr?
        format.json { render :json => { :title => "#{current_employee.firstname} #{current_employee.lastname}",
                                        :shift => all_shifts} }
      end

      format.html
    end
  end

end
