class Customers::FriendsController < ApplicationController
  before_action :authenticate_customer!

  layout "home_page"

  # GET /friends
  def index
    @friends = current_customer.friends.order(:firstname, :lastname)

    unless params[:layout] == "true"
      render :index
    else
      render :partial => "friends"
    end
  end

  # GET /find-friends
  def find
    @friends = current_customer.friendables
  end

  def send_request
    @friend = Customer.find(params[:friend_id])
    current_customer.friend_request(@friend)

    respond_to do |format|
      format.html { redirect_to find_friends_path }
    end
  end

  # POST /accept_request
  def accept_request
    @friend = Customer.find(params[:friend_id])
    current_customer.accept_request(@friend)

    respond_to do |format|
      format.html { redirect_to friends_path }
    end
  end

  def decline_request
    @friend = Customer.find(params[:friend_id])
    current_customer.decline_request(@friend)

    respond_to do |format|
      format.html { redirect_to friends_path }
    end
  end

  # DELETE /remove_friend
  def remove
    @friend = Customer.find(params[:friend_id])
    current_customer.remove_friend(@friend)

    respond_to do |format|
      format.html { redirect_to friends_path }
      format.js
    end
  end

  # GET /search_friends
  def search
    @type = params[:page] == "index" ? :old_friends : :friendables
    @friends = current_customer.search_friends(params[:search], @type).order(:firstname, :lastname)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /pending_requests
  def pending
    @pending = current_customer.requested_friends

    respond_to do |format|
      format.html { render :partial => "pending" }
    end
  end

end
