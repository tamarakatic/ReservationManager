module HomePage::CustomerHomeHelper

  def blocked_friend?(friend_id)
    current_customer.blocked_friends.any? { |friend| friend.id == id}
  end

end
