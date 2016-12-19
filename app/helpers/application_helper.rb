module ApplicationHelper

  def generate_password
    Devise.friendly_token.first(6)
  end

end
