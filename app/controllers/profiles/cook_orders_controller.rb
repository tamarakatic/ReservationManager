class Profiles::CookOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    @customer_order = CustomerOrderPart.where(:status => ['Pending','ProgressFoods'],
                                              :employee_id => current_employee.id)
  end

  def set_prepare
    order_part = CustomerOrderPart.where(:customer_order_id => params[:order_id],
                                         :employee_id => current_employee.id).first

    order = CustomerOrder.find(params[:order_id])

    respond_to do |format|
      order_part.with_lock("FOR SHARE") do

        if order_part.food_deleted?(params[:food_ids])
          redirect_to cook_orders_path, :flash => { :error => "Order cannot be changed!" }
          return
        end

        order_part.update(:status => "ProgressFoods")
        order.update(:status => "Progress")

        broadcast_message "Food is preparing for order #{order.id}"

        format.html {
          redirect_to cook_orders_path, :flash => { :success => "Something is cooking." }
        }
      end
    end
  end

  def finish
    customer_order = CustomerOrderPart.where(:customer_order_id => params[:id][:order_id],
                                             :employee_id => current_employee.id).first

    customer       = CustomerOrder.find(params[:id][:order_id])

    respond_to do |format|
      if customer_order.present?
        customer_order.update(:status => 'ReadyFoods')
        customer.update(:status => 'Ready')

        broadcast_message "Food is finished for order #{customer_order.id}"

        format.html {redirect_to cook_orders_path, :flash => { :success => "Cooking is finished."} }
      else
        format.html {redirect_to cook_orders_path, :flash => { :error => "Order deleted!"} }
      end
    end
  end

  protected

  def broadcast_message(message)
   ActionCable.server.broadcast 'cook_orders',
                                 content: message,
                                 firstname: current_employee.firstname,
                                 lastname: current_employee.lastname,
                                 employee: current_employee.id
  end
end
