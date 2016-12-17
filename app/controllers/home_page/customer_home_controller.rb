class HomePage::CustomerHomeController < ApplicationController
  before_action :authenticate_customer!

  def index
    @friends           = current_customer.friends
    @requested_friends = current_customer.requested_friends
    @users             = Customer.where("id != #{current_customer.id}")
  end

  def send_friend_request
    requested_friend = Customer.find(params[:friend_id])
    current_customer.friend_request(requested_friend)
  end

  def accept_friend_request
    requested_friend = Customer.find(params[:friend_id])
    current_customer.accept_request(requested_friend)
  end

  def decline_friend_request
    requested_friend = Customer.find(params[:friend_id])
    current_customer.decline_request(requested_friend)
  end

  def remove_friend
    requested_friend = Customer.find(params[:friend_id])
    current_customer.remove_friend(requested_friend)
  end

  def block_friend
    requested_friend = Customer.find(params[:friend_id])
    current_customer.block_friend(requested_friend)
  end

  def unblock_friend
    requested_friend = Customer.find(params[:friend_id])
    current_customer.unblock_friend(requested_friend)
  end

end
