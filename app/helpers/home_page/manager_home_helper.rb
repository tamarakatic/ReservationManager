module HomePage::ManagerHomeHelper

  def order_items(offer_item)
    order_item = OrderItem.find(offer_item.order_item_id)

    return '' if order_item.nil?

    order_item
  end

  def offer_item_price(order_item_id)
    offer = OfferItem.where(:order_item_id => order_item_id).first

    return '' if offer.nil?

    offer.price
  end

end
