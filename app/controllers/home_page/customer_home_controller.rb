class HomePage::CustomerHomeController < ApplicationController
  before_action :authenticate_customer!

  def index
    @friends         = current_customer.friends
    @friend_requests = current_customer.requested_friends
    @users           = Customer.where("id != #{current_customer.id}")
  end

  # POST /send_friend_request
  def send_friend_request
    friend = Customer.find(params[:friend_id])
    current_customer.friend_request(friend)
  end

  # POST /accept_friend_request
  def accept_friend_request
    friend = Customer.find(params[:friend_id])
    current_customer.accept_request(friend)
  end

  # POST / decline_friend_request
  def decline_friend_request
    friend = Customer.find(params[:friend_id])
    current_customer.decline_request(friend)
  end

  # DELETE / remove_friend
  def remove_friend
    friend = Customer.find(params[:friend_id])
    current_customer.remove_friend(friend)
  end

end
