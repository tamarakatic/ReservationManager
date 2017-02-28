class ProviderNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'accept_offers'
  end
end
