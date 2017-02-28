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

  def user_profile_path(controller)
    case controller
    when "employee_home"
      employee_profile_path
    when "manager_home"
      manager_profile_path
    when "customer_home"
      edit_customer_registration_path
    when "employee_reon"
      employee_profile_path
    when "employee_calendar"
      employee_profile_path
    when "table_orders"
      employee_profile_path
    when "waiter_orders"
      employee_profile_path
    when "cook_orders"
      employee_profile_path
    else
      root_path
    end
  end

end
