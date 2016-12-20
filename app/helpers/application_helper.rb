module ApplicationHelper

  def generate_password
    Devise.friendly_token.first(9)
  end

end
