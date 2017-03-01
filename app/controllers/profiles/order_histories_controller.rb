class Profiles::OrderHistoriesController < ApplicationController
  before_action :authenticate_employee!

  layout "home_page"

  def index
    customer_orders = ServingTime.where(employee_id: current_employee.id)
    @customer_order = []
    customer_orders.each do |c|
      temp = CustomerOrder.where(status: 'Finished',
                                 id: c.id).first
      unless temp.nil?
        @customer_order << temp
      end
    end
  end
end
