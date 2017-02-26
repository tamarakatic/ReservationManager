module OffersHelper

  def offer_price(order_item_id)
    offer = OfferItem.where(:order_item_id => order_item_id).first

    return '' if offer.nil?

    offer.price
  end

  def datepicker_time(time)
    time.utc.iso8601.gsub("Z", "")
  end
end
