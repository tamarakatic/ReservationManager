class Customers::ReservationsController < ApplicationController
  before_action :authenticate_customer!

  layout "customer_home"

  # GET /customers/reservations/new
  def new
    @friends     = current_customer.friends
    @restaurant  = Restaurant.find(params[:restaurant_id])
    @reservation = Reservation.new
  end

  def create
  end

  # POST /customers/reservations/inite
  def invite

  end

  def cancel
  end

end
