class Profiles::BartenderOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    customer        = CustomerOrderPart.where(:status =>['Pending','ProgressDrinks'],
                                              :employee_id => current_employee.id).to_a

    @customer_order = []

    customer.each do |c|
      @customer_order << c
    end
  end

  def prepare
    customer_order = CustomerOrderPart.where(:customer_order_id => params[:id][:id],
                                             :employee_id => current_employee.id).first

    customer       = CustomerOrder.find(params[:id][:id])
    waiter         = ServingTime.find(customer_order.customer_order_id)
    check_status   = true

    unless customer_order.nil? && waiter.nil?
      customer_order.update(:status => "ProgressDrinks")
      customer.customer_order_parts.each do |part|
        unless part.status == 'ProgressFoods'
          check_status = false
          break
        end
      end
      customer.update(:status => 'Progress') if check_status

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
    customer_order = CustomerOrderPart.where(:customer_order_id => params[:id][:order_id],
                                             :employee_id => current_employee.id).first

    waiter         = ServingTime.find(customer_order.customer_order_id)
    customer       = CustomerOrder.find(params[:id][:order_id])
    check_status   = true

    unless customer_order.nil? && waiter.nil?
      customer_order.update(:status => 'ReadyDrinks')
      customer.customer_order_parts.each do |part|
        unless part.status == 'ReadyFoods'
          check_status = false
          break
        end
      end
      customer.update(:status => 'Ready') if check_status

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
end
