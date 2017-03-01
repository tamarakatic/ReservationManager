class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_manager!

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def accept_offer
    provider = Provider.find(params[:id])
    @restaurant = Restaurant.where(:manager_id => current_manager.id).first
    provider_reject = RestaurantProvider.where(:restaurant_id => @restaurant.id).map { |e| e.provider_id }
    @provider_all = Provider.find(provider_reject)
    reject_providers = @provider_all.reject { |e| e.id == provider.id }.map { |p| p.id }
    @rejected_providers = reject_providers

    ActionCable.server.broadcast 'accept_offers',
      :confirmed_provider => provider.id,
      :message_confirmed => 'Your offer is confirmed!!!',
      :rejected_providers => reject_providers,
      :message_rejected => 'Your offer is rejected!!!'

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.order_items.build
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to root_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to root_path, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:active_from,
                                    :active_till,
                                    :restaurant_id,
                                    :order_items_attributes => [:id, :item, :quantity, :unit_of_measure, :_destroy])
    end
end
