class Customers::ReservationsController < ApplicationController
  before_action :authenticate_customer!

  layout "customer_home"

  # GET /customers/reservations/new
  def new
    @friends     = current_customer.friends
    @restaurant  = Restaurant.find(params[:restaurant_id])
    @reservation = Reservation.new
  end

  # GET /customers/reservations/available_tables
  def available_tables
    @restaurant = Restaurant.find(params[:restaurant_id])

    tables = { :available => [], :reserved => [] }

    respond_to do |format|
      format.js { render :inline => "alert('hello')" }
    end
  end

  def create

  end

  # POST /customers/reservations/inite
  def invite

  end

  def cancel
  end

end
