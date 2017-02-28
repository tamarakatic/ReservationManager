class OfferNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'offer_notifications'
  end
end
