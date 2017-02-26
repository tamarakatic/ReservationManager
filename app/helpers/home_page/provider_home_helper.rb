module HomePage::ProviderHomeHelper

  def offer_exists?(order_id)
     !Offer.where(:order_id => order_id).empty?
  end

  def offer_id(order_id)
    Offer.where(:order_id => order_id, :provider_id => current_provider.id).first
  end

end
