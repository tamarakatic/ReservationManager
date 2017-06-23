class Profiles::BartenderOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @customer_order = CustomerOrderPart.where(:status => ['Pending','ProgressDrinks'],
                                              :employee_id => current_employee.id).to_a
  end

  def prepare
    order_part = CustomerOrderPart.where(:customer_order_id => params[:customer_order_id],
                                         :employee_id => current_employee.id).first

    order      = CustomerOrder.find(params[:customer_order_id)
    waiter     = ServingTime.find(customer_order.customer_order_id)

    respond_to do |format|
      order_part.with_lock("FOR SHARE") do

        if order_part.drink_deleted?(params[:drink_ids]) do
          redirect_to bartender_orders_path, :flash => { :error => "Order can't be changed!" }
          return
        end

        order_part.update(:status => "ProgressDrinks")
        order.update(:status => "Progress")

        broadcast_message "Drink is preparing for order #{order.id}", waiter

        format.html {
          redirect_to bartender_orders_path, :flash => { :success => "Drink is preparing" }
        }
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

      broadcast_message "Drink is finished for order #{customer_order.id}", waiter

      respond_to do |format|
        format.html {redirect_to employee_profile_path}
      end
    end
  end

  private

  def broadcast_message(message, waiter)
    ActionCable.server.broadcast 'bartender_orders',
                                  content: , message,
                                  firstname: current_employee.firstname,
                                  lastname: current_employee.lastname,
                                  employee: waiter.id
  end

end
