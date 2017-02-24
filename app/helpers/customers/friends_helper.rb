module Customers::FriendsHelper

  def pending_requests
    current_customer.requested_friends.count
  end

end
