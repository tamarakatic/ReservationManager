# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class BartenderOrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bartender_orders"
  end
end
