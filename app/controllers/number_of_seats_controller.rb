class NumberOfSeatsController < ApplicationController
  before_action :set_number_of_seat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_manager!

  layout 'restaurant_home'

  # GET /number_of_seats
  # GET /number_of_seats.json
  def index
    @number_of_seats = NumberOfSeat.all
  end

  # GET /number_of_seats/1
  # GET /number_of_seats/1.json
  def show
    @number_of_seats = NumberOfSeat.all
    @restaurant = current_manager.restaurant
  end

  # GET /number_of_seats/new
  def new
    @number_of_seat = NumberOfSeat.new
    @seat = Seat.where(:id => params[:seat_id])
    @restaurant = current_manager.restaurant
  end

  # GET /number_of_seats/1/edit
  def edit
    @restaurant = current_manager.restaurant
  end

  # POST /number_of_seats
  # POST /number_of_seats.json
  def create
    @number_of_seat = NumberOfSeat.new(number_of_seat_params)

    respond_to do |format|
      if @number_of_seat.save
        format.html { redirect_to list_seat_path, notice: 'Number of seat was successfully created.' }
        format.json { render :show, status: :created, location: @number_of_seat }
      else
        format.html { render :new }
        format.json { render json: @number_of_seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /number_of_seats/1
  # PATCH/PUT /number_of_seats/1.json
  def update
    respond_to do |format|
      if @number_of_seat.update(number_of_seat_params)
        format.html { redirect_to list_seat_path, notice: 'Number of seat was successfully updated.' }
        format.json { render :show, status: :ok, location: @number_of_seat }
      else
        format.html { render :edit }
        format.json { render json: @number_of_seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /number_of_seats/1
  # DELETE /number_of_seats/1.json
  def destroy
    @number_of_seat.destroy
    respond_to do |format|
      format.html { redirect_to list_seat_path, notice: 'Number of seat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number_of_seat
      @number_of_seat = NumberOfSeat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_of_seat_params
      params.require(:number_of_seat).permit(:number, :seatstable, :seat_id)
    end
end
