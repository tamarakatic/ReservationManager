class EmployeeShiftController < ApplicationController
  before_action :set_employee_shift, only: [:edit, :update]
  before_action :authenticate_manager!

  def index
  end

  def new

  end

  def create

  end

  def edit

  end


  def update

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
