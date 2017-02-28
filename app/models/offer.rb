class Offer < ApplicationRecord
  belongs_to :provider
  belongs_to :order
  has_many :offer_items

  after_save :broadcast_notification

  after_update :update_notification

  def broadcast_notification
    ActionCable.server.broadcast 'offer_notifications',
      :notification => "Offer created!!!"
  end

  def update_notification
    ActionCable.server.broadcast 'offer_notifications',
      :notification => "Offer is updated!!!"
  end

end
