class Profiles::BartenderOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    customer = CustomerOrderPart.where(:status =>['Pending','ProgressDrinks'],:employee_id => current_employee.id).to_a
    @customer_order = []
    customer.each do |c|
        @customer_order << c
      end
  end

  def prepare
    customer_order = CustomerOrderPart.where(:customer_order_id => params[:id][:id], :employee_id => current_employee.id).first
    customer = CustomerOrder.find(params[:id][:id])
    waiter = ServingTime.find(customer_order.customer_order_id)
    unless customer_order.nil? and waiter.nil?
      customer_order.update(:status => "ProgressDrinks")
      customer.customer_order_parts.each do |part|
        if part.status == 'ProgressFoods'
          customer.update(:status => 'Progress')
          break
        end
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
    customer_order = CustomerOrderPart.where(:customer_order_id => params[:id][:order_id],:employee_id => current_employee.id).first
    waiter = ServingTime.find(customer_order.customer_order_id)
    customer = CustomerOrder.find(params[:id][:order_id])
    unless customer_order.nil? and waiter.nil?
      customer_order.update(:status => 'ReadyDrinks')
      customer.customer_order_parts.each do |part|
        if part.status == 'ReadyFoods'
          customer.update(:status => 'Ready')
          break
        end
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
