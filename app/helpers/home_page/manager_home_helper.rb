module HomePage::ManagerHomeHelper

  def order_items(offer_item)
    order_item = OrderItem.find(offer_item.order_item_id)

    return '' if order_item.nil?

    order_item
  end

  def offer_item_price(price)
      return '' if price.nil?

    price
  end

  def current_order(order_id)
    order = Order.find(order_id)
  end

end
