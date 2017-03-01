class Profiles::BartenderOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    customer = CustomerOrder.where(:status =>['Pending','ProgressDrinks','ProgressDrinksWithReadyFoods','Progress','ReadyFoods','Active'] )
    employee_shift = EmployeeShift.where(employee_id: current_employee.id)
    @customer_order = []
    customer.each do |c|
      employee_shift.each do |emp|
        shift = Shift.find(emp.shift_id)
        addCostumerOrder(@customer_order, c, shift)
      end
    end
  end

  def prepare
    customer_order = CustomerOrder.find(params[:id][:id])
    waiter = ServingTime.find(customer_order.id)
    unless customer_order.nil? and waiter.nil?
      if(customer_order.status == 'ProgressFoods')
        customer_order.update(:status => 'Progress')
      elsif(customer_order.status == 'ReadyFoods')
        customer_order.update(:status => 'ProgressDrinksWithReadyFoods')
      else
        customer_order.update(:status => "ProgressDrinks")
      end
      ActionCable.server.broadcast 'bartender_orders',
                                    content: "Drink is preparing for order #{customer_order.id}",
                                    firstname: current_employee.firstname,
                                    lastname: current_employee.lastname,
                                    employee: waiter.id

      respond_to do |format|
        format.html {redirect_to bartender_orders_path}
      end
    end
  end

  def finish
    customer_order = CustomerOrder.find(params[:id][:order_id])
    waiter = ServingTime.find(customer_order.id)
    unless customer_order.nil? and waiter.nil?
        if(customer_order.status == 'ReadyFoods' or customer_order.status == 'ProgressDrinksWithReadyFoods')
          customer_order.update(:status => 'Ready')
        else
          customer_order.update(:status => 'ReadyDrinks')
        end
       ActionCable.server.broadcast 'bartender_orders',
                                     content: "Drink is finished for order #{customer_order.id}",
                                     firstname: current_employee.firstname,
                                     lastname: current_employee.lastname,
                                     employee: waiter.id

      respond_to do |format|
        format.html {redirect_to employee_profile_path}
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
        if(timeMinutes <= endMinutes)
          @customer_order << c
        end
      elsif(timeHours > start and timeHours < endHours)
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
