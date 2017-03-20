class CustomerOrdersController < ApplicationController
  before_action :authenticate_customer!

  # DELETE /customer_orders/cancel_order
  def cancel_order
    reservation = Reservation.find(params[:reservation])

    unless reservation.cancelable?
      redirect_to customers_reservations_show_path(:id => params[:reservation]),
        :alert => "It is to late for order to be canceled." and return
    end

    begin
      cancel_food_order  if params[:class_name] == "Food"
      cancel_drink_order if params[:class_name] == "Drink"
    rescue
      redirect_to customers_reservations_show_path(:id => params[:reservation]),
        :alert => "Order can not be canceled." and return
    end

    redirect_to customers_reservations_show_path(:id => params[:reservation]),
      :flash => { :success => "Order canceled." }
  end

  private

  def cancel_food_order
    CustomerOrderFood.where(:food_id           => params[:item],
                            :customer_order_id => params[:order]).delete_all
  end

  def cancel_drink_order
    CustomerOrderDrink.where(:drink_id          => params[:item],
                             :customer_order_id => params[:order]).delete_all
  end

end
