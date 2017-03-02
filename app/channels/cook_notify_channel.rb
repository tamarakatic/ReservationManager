class CookNotifyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cook_notify"
  end
end
