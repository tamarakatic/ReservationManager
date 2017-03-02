class BartenderNotifyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bartender_notify"
  end
end
