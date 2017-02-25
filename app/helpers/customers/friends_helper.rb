module Customers::FriendsHelper

  def pending_requests
    current_customer.requested_friends.count
  end

  def action_path(action, friend_id)
    case action
    when "remove"
      remove_friend_path(:friend_id => friend_id)
    when ""
      accept_friend_path(:friend_id => friend_id)
    when "find"
      send_request_path(:friend_id => friend_id)
    end
  end

end
