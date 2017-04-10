module LandingPageHelper
  # Heleprs for custom devise views

  def resource_name
    :customer
  end

  def resource
    @resource ||= Customer.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:customer]
  end

end
