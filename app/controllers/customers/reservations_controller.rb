class Customers::ReservationsController < ApplicationController
  before_action :authenticate_customer!

  layout "customer_home"

  def index
    @reservation = Reservation.find(params[:reservation_id])

    unless @reservation.invitations.any? { |inv| inv.customer.id == current_customer.id }
      redirect_to root_path
    end
  end

  # GET /custoemrs/reservations/show/1
  def show
    @reservation = Reservation.find(params[:id])
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

    reservation_start = to_date_time(params[:reservation_start])
    reservation_end   = to_date_time(params[:reservation_end])

    tables = { :available => [], :reserved => [] }

    @restaurant.tables.each do |table|
      table_hash = table.as_json.merge(:area_name => table.seat.area,
                                       :area_id   => table.seat.id)

      if table.reserved?(reservation_start, reservation_end)
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
    reservation_start = to_date_time(params[:start])
    reservation_end   = to_date_time(params[:end])

    reservation = Reservation.new(:restaurant_id => params[:restaurant],
                                  :host          => current_customer,
                                  :reserved_from => reservation_start,
                                  :reserved_to   => reservation_end)

    if params[:tables].empty?
      redirect_to customers_reservations_new_path(:restaurant_id => params[:restaurant]),
        :alert => "You must select table." and return
    end

    ActiveRecord::Base.transaction do
      params[:tables].each do |table_id|
        table = NumberOfSeat.lock.find(table_id)

        if table.reserved?(reservation_start, reservation_end)
          redirect_to customers_reservations_new_path(:restaurant_id => params[:restaurant]),
            :alert => "One of the selected tables is already reserved." and return
        end

        reservation.reserved_tables.build(:table => table)
      end

      unless params[:friends].nil?
        params[:friends].each do |friend|
          reservation.invitations.build(:customer_id => friend, :status => :pending)
        end
      end

      create_order(reservation)

      if reservation.save
        redirect_to customers_reservations_history_path,
          :flash => { :success => "Reservation successful." }
      else
        redirect_to customers_reservations_new_path(:restaurant_id => params[:restaurant]),
          :flash => { :error => reservation.errors.messages.values.join("\n").html_safe }
      end
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

  def history
    @host_reservations  = current_customer.host_reservations
    @guest_reservations = current_customer.guest_reservations
  end

  # POST /customers/reservations/cancel
  def cancel
    if Reservation.destroy(params[:id])
      redirect_to customers_reservations_history_path,
        :flash => { :success => "Reservation canceled." }
    else
      redirect_to customers_reservations_show_path(:id => params[:id]),
        :alert => "Reservation can not be cancelled in this moment."
    end
  end

  # GET|POST /customers/reservations/orders
  def orders
    @reservation = Reservation.find(params[:reservation])

    if request.post?
      create_order(@reservation)

      if @reservation.save!
        redirect_to root_path
      else
        render :inline => "alert('Error! Please try again.')"
      end
    end
  end

  private

  def to_date_time(ms)
    Time.at(ms.to_f / 1000)
  end

  def create_order(reservation)
    if params[:orders].present?
      customer_order = CustomerOrder.new(:customer => current_customer)

      if params[:orders][:foods].present?
        params[:orders][:foods].each do |food|
          customer_order.customer_order_foods.build(:food_id => food)
        end
      end

      if params[:orders][:drinks].present?
        params[:orders][:drinks].each do |drink|
          customer_order.customer_order_drinks.build(:drink_id => drink)
        end
      end

      reservation.reservation_orders.build(:customer_order => customer_order)
    end
  end

end
