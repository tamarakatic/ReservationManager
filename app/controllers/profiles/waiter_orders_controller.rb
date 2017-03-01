class Profiles::WaiterOrdersController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    customer_orders = ServingTime.where(employee_id: current_employee.id)
    @customer_order = []
    customer_orders.each do |c|
      temp = CustomerOrder.where(:status => ['Active','Pending','ProgressFoods','ProgressDrinks','Ready','ReadyFoods','ReadyDrinks'], id: c.id).first
      unless temp.nil?
        @customer_order << temp
      end
    end
  end

  def finish
    customer_order = CustomerOrder.find(params[:id][:order_id])
    customer_order.update(:status => 'Finished')
    respond_to do |format|
      format.html {redirect_to employee_profile_path }
    end
  end

end
