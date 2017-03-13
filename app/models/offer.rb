class Offer < ApplicationRecord
  belongs_to :provider
  belongs_to :order
  has_many :offer_items

  enum offer_state: [:active, :rejected, :accepted]

  after_update :updated_notification

  after_create :created_notification

  def created_notification
    ActionCable.server.broadcast 'offer_notifications',
      :notification => "Offer is created!!!"
  end

  def updated_notification
    ActionCable.server.broadcast 'offer_notifications',
      :notification => "Offer is updated!!!"
  end

end
