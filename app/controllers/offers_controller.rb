class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_provider!

  layout "home_page"

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @order_items = OrderItem.where(:order_id => params[:order_id])
  end

  # GET /offers/1/edit
  def edit
    @order_items = OrderItem.where(:order_id => params[:order_id])
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(:order_id => params[:order_id],
                       :provider_id => current_provider.id)


    respond_to do |format|
      if @offer.save!
        @offer.offer_items.build

        params[:offer_items].each do |order_item_id, price|
          if price == ""
            @offer.offer_items.create!(:price => 0, :order_item_id => order_item_id)
          else
            @offer.offer_items.create!(:price => price, :order_item_id => order_item_id)
          end
        end

        format.html { redirect_to root_path, notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    @offer = Offer.where(:order_id => params[:order_id],
                         :provider_id => current_provider.id).first

    respond_to do |format|
      params[:offer_items].each do |order_item_id, price|
        if @offer.offer_items.where(:order_item_id => order_item_id).first.price != price
          unless @offer.offer_items.where(:order_item_id => order_item_id).first.update(:price => price)
            format.html { redirect_to edit_offer_path(@offer.id, :order_id => params[:order_id]), notice: 'Warnning!!! Price is invalid.' }
          end
        end
      end

      format.html { redirect_to root_path, notice: 'Offer was successfully updated.' }
      format.json { render :show, status: :ok, location: @offer }

    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_restaurant
  #     @restaurant = Restaurant.find(params[:restaurant_id])
  #   end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:provider_id,
                                    :restaurant_id,
                                    :order_id,
                                    :price)
    end
end
