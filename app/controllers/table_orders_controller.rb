class TableOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @customer_order = CustomerOrder.find(params[:customer_order])
    @foods          = Food.all
    @drinks         = Drink.all
    @cooks          = employee_in_shift("Cook")
    @bartenders     = employee_in_shift("Bartender")
    @restaurant     = Restaurant.find(current_employee.manager_id)
  end

  # PUT /table_orders/foods
  def add_foods
    food           = Food.find(params[:id][:food_id])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.foods << food

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id) }
    end
  end

  # DELETE /table_orders
  def delete_food
    food           = Food.find(params[:id][:food_id])
    customer_order = CustomerOrder.find(params[:id][:customer_id])

    respond_to do |format|
      if customer_order.delete_food_order(food)
        format.html { redirect_to table_orders_path(:customer_order => customer_order.id),
          :flash => { :success => "#{food.name} deleted." } }
      else
        format.html { redirect_to table_orders_path(:customer_order => customer_order.id),
          :error => "#{food.name} cannot be deleted." }
      end
    end
  end

  # PUT /table_orders/exchange
  def exchange_food
    food           = Food.find(params[:id][:food_id])
    exchange_food  = Food.find(params[:id][:food_id_to_exchange])
    customer_order = CustomerOrder.find(params[:id][:customer_order])

    respond_to do |format|
      if customer_order.exchange_food_order(food, exchange_food)
        format.html { redirect_to table_orders_path(:customer_order => customer_order.id),
          :flash => { :success => "#{food.name} exchanged to #{exchange_food.name}." } }
      else
        format.html { redirect_to table_orders_path(:customer_order => customer_order.id),
          :flash => { :error => "#{food.name} cannot be exchanged." } }
      end
    end
  end

  # PUT /table_orders/drinks
  def add_drinks
    drink          = Drink.find(params[:id][:drink_id])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.drinks << drink

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id) }
    end
  end

  # DELETE /table_orders/remove_drinks
  def delete_drink
    drink          = Drink.find(params[:id][:drink_id])
    customer_order = CustomerOrder.find(params[:id][:customer_id])
    customer_order.drinks.delete(drink)

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end

  # PUT /table_orders/exchange_drink
  def exchange_drink
    drink          = Drink.find(params[:id][:drink_id])
    drink_ex       = Drink.find(params[:id][:drink_id_to_exchange])
    customer_order = CustomerOrder.find(params[:id][:customer_order])
    customer_order.drinks.delete(drink)
    customer_order.drinks << drink_ex

    respond_to do |format|
      format.html { redirect_to table_orders_path(:customer_order => customer_order.id)}
    end
  end

  # POST /table_orders/notify_cook
  def notify_cook
    food     = Food.find(params[:id][:food_id])
    employee = Employee.find(params[:id][:cook_id])
    customer = CustomerOrder.find(params[:id][:customer_id])
    temp     = CustomerOrderPart.where(:employee_id       => params[:id][:cook_id],
                                       :customer_order_id => params[:id][:customer_id]).first
    if temp.nil?
      part = CustomerOrderPart.new(:customer_order_id => params[:id][:customer_id],
                                   :employee_id       => params[:id][:cook_id],
                                   :status            => 'Pending')
      part.foods << food
      if part.save!
        ActionCable.server.broadcast 'cook_notify',
                                      content: "Your need to prepare food",
                                      firstname: current_employee.firstname,
                                      lastname: current_employee.lastname,
                                      employee: employee.id
        respond_to do |format|
          format.html {redirect_to table_orders_path(:customer_order => customer.id) }
        end
      end
    else
      temp.foods << food
      temp.update(:status => 'Pending') if temp.status == 'ReadyFoods' ||
                                           temp.status == 'ProgressFoods'

      ActionCable.server.broadcast 'cook_notify',
                                    content: "Your need to prepare one more meal",
                                    firstname: current_employee.firstname,
                                    lastname: current_employee.lastname,
                                    employee: employee.id
      respond_to do |format|
        format.html {redirect_to table_orders_path(:customer_order => customer.id) }
      end
    end
    redirect_to table_orders_path(:customer_order => customer.id)
  end

  # POST /table_orders/notify_bartender
  def notify_bartender
    drink    = Drink.find(params[:id][:drink_id])
    employee = Employee.find(params[:id][:bart_id])
    customer = CustomerOrder.find(params[:id][:customer_id])
    temp     = CustomerOrderPart.where(:employee_id       => params[:id][:bart_id],
                                       :customer_order_id => params[:id][:customer_id]).first
    if temp.nil?
      part = CustomerOrderPart.new(:customer_order_id => params[:id][:customer_id],
                                   :employee_id       => params[:id][:bart_id],
                                   :status            => 'Pending')
      part.drinks << drink
      if part.save!
        ActionCable.server.broadcast 'bartender_notify',
                                      content: " Your need to prepare drink",
                                      firstname: current_employee.firstname,
                                      lastname: current_employee.lastname,
                                      employee: employee.id
        respond_to do |format|
          format.html {redirect_to table_orders_path(:customer_order => customer.id) }
        end
      end
    else
      temp.drinks << drink
      temp.update(:status => 'Pending') if temp.status == 'ReadyDrinks' ||
                                           temp.status == 'ProgressDrinks'

      ActionCable.server.broadcast 'bartender_notify',
                                    content: "Your need to prepare one more drink",
                                    firstname: current_employee.firstname,
                                    lastname: current_employee.lastname,
                                    employee: employee.id
      respond_to do |format|
        format.html {redirect_to table_orders_path(:customer_order => customer.id) }
      end
    end
    redirect_to table_orders_path(:customer_order => customer.id)
  end

  private

  def employee_in_shift(type)
    emp             = Employee.where(:type => type)
    customer_order  = CustomerOrder.find(params[:customer_order])
    temp_emp        = []

    emp.each do |cook|
      cook_shifts  = EmployeeShift.where(employee_id: cook.id)
      cook_shifts.each do |shift|
        sh         = Shift.find(shift.shift_id)
        date       = customer_order.order_time.strftime("%Y-%m-%d")
        shift_date = sh.work_day.strftime("%Y-%m-%d")

        if shift_date == date
          time_hours, time_minutes = format_end_time(customer_order.order_time.strftime("%I:%M:%p"))
          start                    = format_start_time(sh.start_at.strftime("%I:%p"))
          end_hours, end_minutes   = format_end_time(sh.end_at.strftime("%I:%M:%p"))

          if time_hours > start && time_hours == end_hours
            temp_emp << cook if time_minutes <= end_minutes
          elsif time_hours > start && time_hours < end_hours
            temp_emp << cook
          end
        end
      end
    end
    temp_emp
  end

  def format_start_time(time)
    t          = time.split(':')
    final_time = t[0].to_i

    if t[1] == "PM" && t[1] != 12
      final_time += 12
    end
    final_time
  end

  def format_end_time(time)
    t       = time.split(':')
    hours   = t[0].to_i
    minutes = t[1].to_i

    if t[2] == "PM" && t[2] !=12
      hours += 12
    end
    return hours, minutes
  end

end
