class OrderNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'order_notifications'
  end
end
