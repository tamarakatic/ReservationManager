class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :offers
  has_many :order_items

  after_save :broadcast_notification

  accepts_nested_attributes_for :order_items, :reject_if => :all_blank,
                                              :allow_destroy => true

  def broadcast_notification
    ActionCable.server.broadcast 'order_notifications',
      :notification => "New order created!!!"
  end

end
