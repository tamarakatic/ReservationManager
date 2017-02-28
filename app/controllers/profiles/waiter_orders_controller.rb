class Profiles::WaiterOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    customer = CustomerOrder.where.not(status: 'Finished' )
    employee_shift = EmployeeShift.where(employee_id: current_employee.id)
    @customer_order = []
    customer.each do |c|
      employee_shift.each do |emp|
        shift = Shift.find(emp.shift_id)
        seat = Seat.find_by_id(emp.seat_id)
        if seat.nil?
          return
        else
          unless (seat.number_of_seats - c.number_of_seats).empty?
            addCostumerOrder(@customer_order,c,shift)
          end
        end
      end
    end
  end



  private

  def addCostumerOrder(costumer_order, c, shift)
    date = c.order_time.strftime("%Y-%m-%d")
    shift_date = shift.work_day.strftime("%Y-%m-%d")
    if(date == shift_date)
      timeHours, timeMinutes = formatEndTime(c.order_time.strftime("%I:%M:%p"))
      start = formatTime(shift.start_at.strftime("%I:%p"))
      endHours, endMinutes = formatEndTime(shift.end_at.strftime("%I:%M:%p"))
      if(timeHours > start and timeHours == endHours)
        if(timeMinutes < endMinutes)
          unless c.status == 'Finished'
            @customer_order << c
          end
        end
      elsif(timeHours > start and timeHours < endHours)
          unless c.status == 'Finished'
            @customer_order << c
          end
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

  def formatEndTime(time)
    t = time.split(':')
    hours = t[0].to_i
    minutes = t[1].to_i
    if(t[2] == "PM")
      hours += 12
    end
    return hours, minutes
  end
end
