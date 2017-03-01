class EmployeeShiftsController < ApplicationController
  before_action :set_employee_shift, only: [:edit, :update]
  before_action :authenticate_manager!

  layout "home_page"

  def index
    @employee_shifts = EmployeeShift.all
    @area = Seat.all
    @employee_all = Employee.all

    all_employee = []
    all_shift = []

    @employee_shifts.each do |empl_shift|
      @employee = Employee.find(empl_shift.employee_id)
      @shift = Shift.find(empl_shift.shift_id)
      all_employee << @employee
      all_shift << @shift
    end

    if request.xhr?
      render :json => { :employee => all_employee,
                        :shift => all_shift }
    end

  end


  def new
  end

  def create
    @employee = Employee.find(params[:employee_id])

    @shift = Shift.new(:work_day => Date.parse(params[:current_date]), :start_at => Time.parse(params[:start_at]), :end_at => Time.parse(params[:end_at]))
    @shift.save!

    @employee_shift = EmployeeShift.new(:employee_id => @employee.id, :shift_id => @shift.id, :seat_id => params[:role])
    respond_to do |format|
      if @employee_shift.save!
        # format.html { redirect_to employee_shifts_path(@employee_shift), notice: 'Offer was successfully created.' }
        format.json {render :json =>{ :employee => @employee,
                                      :shift => @shift}}
      else
        format.html { render_to root_path }
      end
    end
  end

  def edit

  end


  def update
    @employee = Employee.find(params[:employee_id])
    @employee_shift = EmployeeShift.where(:employee_id => @employee.id).first

    @shift = Shift.find(@employee_shift.shift_id)

    @shift.update(:work_day => Date.parse(params[:current_date]), :start_at => Time.parse(params[:start_at]), :end_at => Time.parse(params[:end_at]))

    respond_to do |format|
      if @employee_shift.update(:employee_id => @employee.id, :shift_id => @shift.id, :seat_id => params[:role])
        format.html { redirect_to @employee_shift, notice: 'Food was successfully updated.' }
        format.json {render :json =>{ :employee => @employee,
                                      :shift => @shift}}
      else
        format.html { render_to root_path }
      end
    end
  end


  private

    def set_employee_shift
      @employee_shift = EmployeeShift.find(params[:id])
    end

    def employee_shift_params
      params.require(:employee_shift).permit(:employee_id,
                                             :shift_id,
                                             :seat_id)
    end

end
