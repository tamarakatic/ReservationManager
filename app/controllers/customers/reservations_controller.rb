class Customers::ReservationsController < ApplicationController
  before_action :authenticate_customer!

  layout "customer_home"

  def index
    @reservation = Reservation.find(params[:reservation_id])

    unless @reservation.invitations.any? { |inv| inv.customer.id == current_customer.id }
      redirect_to root_path
    end
  end

  # GET /customers/reservations/new
  def new
    @friends     = current_customer.friends
    @restaurant  = Restaurant.find(params[:restaurant_id])
    @reservation = Reservation.new
  end

  # GET /customers/reservations/available_tables
  def available_tables
    @restaurant = Restaurant.find(params[:restaurant_id])

    new_reservation_start = to_date_time(params[:reservation_start])
    new_reservation_end   = to_date_time(params[:reservation_end])

    tables = { :available => [], :reserved => [] }

    @restaurant.tables.each do |table|
      reserved = table.reservations.any? do |reservation|
        interval_overlaps?(reservation.reserved_from, reservation.reserved_to,
                           new_reservation_start, new_reservation_end)
      end

      table_hash = table.as_json.merge(:area_name => table.seat.area,
                                       :area_id   => table.seat.id)
      if reserved
        tables[:reserved] << table_hash
      else
        tables[:available] << table_hash
      end
    end

    respond_to do |format|
      format.json { render :json => tables }
    end
  end

  # POST /customers/reservations/create
  def create
    reservation = Reservation.new

    restaurant        = Restaurant.find(params[:restaurant])
    reservation_start = to_date_time(params[:start])
    reservation_end   = to_date_time(params[:end])

    reservation.restaurant    = Restaurant.find(params[:restaurant])
    reservation.owner         = current_customer
    reservation.reserved_from = reservation_start
    reservation.reserved_to   = reservation_end

    if reservation.save!
      params[:tables].each do |table|
        reservation.reserved_tables.create(:table => NumberOfSeat.find(table))
      end

      params[:friends].each do |friend|
        reservation.invitations.create(:customer => Customer.find(friend), :status => :pending)
      end
    end

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def accept
    @reservation = Reservation.find(params[:reservation_id])
    invitation = ReservationInvitation.where(:reservation_id => @reservation.id,
                                             :customer_id => current_customer.id).first
    invitation.accepted!
    redirect_to customers_reservations_orders_path(:reservation => @reservation.id)
  end

  def decline
    invitation = ReservationInvitation.where(:reservation_id => params[:reservation_id],
                                             :customer_id => current_customer.id).first
    invitation.declined!
    redirect_to root_path
  end

  def cancel
  end

  def orders
    @reservation = Reservation.find(params[:reservation])
  end

  private

  def to_date_time(ms)
    Time.at(ms.to_f / 1000)
  end

  def interval_overlaps?(first_start, first_end, second_start, second_end)
    (first_start - second_end) * (second_start - first_end) >= 0
  end

end
