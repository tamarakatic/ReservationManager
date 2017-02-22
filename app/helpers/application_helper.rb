module ApplicationHelper

  def generate_password
    Devise.friendly_token.first(9)
  end

  def current_user_logout_path
    destroy_customer_session_path ||
    destroy_manager_session_path  ||
    destroy_employee_session_path ||
    destroy_provider_session_path ||
    destroy_system_manager_session_path
  end

end
