class Profiles::CookOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    customer = CustomerOrder.where.not(status: 'Finished' )
    employee_shift = EmployeeShift.where(employee_id: current_employee.id)
    @customer_order = []
    customer.each do |c|
      employee_shift.each do |emp|
        shift = Shift.find(emp.shift_id)
        addCostumerOrder(@customer_order, c, shift)
      end
    end
  end

  private

  def addCostumerOrder(costumer_order, c, shift)
    date = c.order_time.strftime("%Y-%m-%d")
    shift_date = shift.work_day.strftime("%Y-%m-%d")
    if(date == shift_date)
      time = formatTime(c.order_time.strftime("%I:%p"))
      start = formatTime(shift.start_at.strftime("%I:%p"))
      endTime = formatTime(shift.end_at.strftime("%I:%p"))
      if(time > start and time < endTime)
        @customer_order << c
      end
    end
  end

  def formatTime(time)
    t = time.split(':')
    finalTime = t[0].to_i
    if(t[1] == "PM")
      finalTime += 12
    end
    finalTime
  end
end
