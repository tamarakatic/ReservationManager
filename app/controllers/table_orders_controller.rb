class TableOrdersController < ApplicationController
  before_action :authenticate_employee!
  before_action :checkActivity

  layout "home_page"

  def index
    @customer_order = CustomerOrder.find(params[:customer_order])
    @foods = Food.all
    @drinks = Drink.all
    @cooks = empInShift("Cook")
    @bartenders = empInShift("Bartender")
    @restaurant = Restaurant.find(current_employee.manager_id)
  end

  def add_foods
    food = Food.find(params[:id][:food_id])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.foods << food

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id) }
      # format.js
    end
  end

  def delete_food
    food = Food.find(params[:id][:food_id])
    customer_order = CustomerOrder.find(params[:id][:customer_id])
    customer_order.foods.delete(food)

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end

  def exchange_food
    food = Food.find(params[:id][:food_id])
    food_ex = Food.find(params[:id][:food_id_to_exchange])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.foods.delete(food)
    customer_order.foods << food_ex

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end

  def add_drinks
    drink = Drink.find(params[:id][:drink_id])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.drinks << drink

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id) }
      # format.js
    end
  end

  def delete_drink
    drink = Drink.find(params[:id][:drink_id])
    customer_order = CustomerOrder.find(params[:id][:customer_id])
    customer_order.drinks.delete(drink)

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end

  def exchange_drink
    drink = Drink.find(params[:id][:drink_id])
    drink_ex = Drink.find(params[:id][:drink_id_to_exchange])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.drinks.delete(drink)
    customer_order.drinks << drink_ex

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end

  private

  def empInShift(type)
    emp = Employee.where(:type => type)
    customer_order = CustomerOrder.find(params[:customer_order])
    tempEmp = []
    emp.each do |cook|
      cook_shifts = EmployeeShift.where(employee_id: cook.id)
      cook_shifts.each do |shift|
        sh = Shift.find(shift.shift_id)
        date = customer_order.order_time.strftime("%Y-%m-%d")
        shift_date = sh.work_day.strftime("%Y-%m-%d")
        if(shift_date == date)
          timeHours, timeMinutes = formatEndTime(customer_order.order_time.strftime("%I:%M:%p"))
          start = formatStartTime(sh.start_at.strftime("%I:%p"))
          endHours, endMinutes = formatEndTime(sh.end_at.strftime("%I:%M:%p"))
          if(timeHours > start and timeHours == endHours)
            if(timeMinutes <= endMinutes)
              tempEmp << cook
            end
          elsif(timeHours > start and timeHours < endHours)
            tempEmp << cook
          end
        end
      end
    end
    tempEmp
  end

  def formatStartTime(time)
    t = time.split(':')
    finalTime = t[0].to_i
    if(t[1] == "PM" and t[1] != 12)
      finalTime += 12
    end
    finalTime
  end

  def formatEndTime(time)
    t = time.split(':')
    hours = t[0].to_i
    minutes = t[1].to_i
    if(t[2] == "PM" and t[2] !=12 )
      hours += 12
    end
    return hours, minutes
  end

  def checkActivity
    customer_order = CustomerOrder.find(params[:customer_order])
    if customer_order.nil? or customer_order.status == "Ready"
      redirect_to waiter_orders_path
    end
  end
end
