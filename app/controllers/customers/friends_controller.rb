class Customers::FriendsController < ApplicationController
  before_action :authenticate_customer!

  layout "home_page"

  def index
    @friends = current_customer.friends.order(:firstname, :lastname)

    unless params[:layout] == "true"
      render :index
    else
      render :partial => "show", :collection => @friends, :as => :friend, :layout => false
    end
  end

  # DELETE / remove_friend
  def remove
    @friend = Customer.find(params[:friend_id])
    current_customer.remove_friend(@friend)

    respond_to do |format|
      format.html { redirect_to friends_path }
      format.js
    end
  end

  # GET /search
  def search
    @friends = current_customer.search_friends(params[:search]).order(:firstname, :lastname)

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  def pending
    @pending = current_customer.requested_friends

    respond_to do |format|
      format.html { render :partial => "pending" }
    end
  end

end
