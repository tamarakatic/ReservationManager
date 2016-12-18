class HomePage::CustomerHomeController < ApplicationController
  before_action :authenticate_customer!

  def index
    @friends         = current_customer.friends
    @friend_requests = current_customer.requested_friends
    @users           = Customer.where("id != #{current_customer.id}")
  end

  def send_friend_request
    friend = Customer.find(params[:friend_id])
    current_customer.friend_request(friend)
  end

  def accept_friend_request
    friend = Customer.find(params[:friend_id])
    current_customer.accept_request(friend)
  end

  def decline_friend_request
    friend = Customer.find(params[:friend_id])
    current_customer.decline_request(friend)
  end

  def remove_friend
    friend = Customer.find(params[:friend_id])
    current_customer.remove_friend(friend)
  end

end
