module OffersHelper

  def offer_price(order_item_id)
    offer = Offer.where(:order_item_id => order_item_id).first

    return '' if offer.nil?

    offer.price
  end

  def button_change(item_id)
    offer = Offer.where(:order_item_id => item_id).first

    return "Add" if offer.nil?

    "Edit"
  end
end
