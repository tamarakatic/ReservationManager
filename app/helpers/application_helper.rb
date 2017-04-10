module ApplicationHelper

  def generate_password
    Devise.friendly_token.first(9)
  end

  def current_date
    Time.now.utc.iso8601.gsub("Z", "")
  end

  def current_user_logout_path
    return destroy_system_manager_session_path if current_system_manager.present?
    return destroy_customer_session_path       if current_customer.present?
    return destroy_manager_session_path        if current_manager.present?
    return destroy_employee_session_path       if current_employee.present?
    return destroy_provider_session_path       if current_provider.present?
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
    when "order_histories"
      employee_profile_path
    else
      root_path
    end
  end

  def notif_path(controller)
    case controller
    when "employee_home"
      employee_notifications_path
    else
      root_path
    end
  end

  BOOTSTRAP_FLASH_TYPE = {
    :success => "alert-success",
    :error   => "alert-danger",
    :alert   => "alert-warning",
    :notice  => "alert-info"
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_TYPE.fetch(flash_type, flash_type.to_s)
  end

  def flash_messages
    flash.each do |type, message|
      concat(
        content_tag(:div, :class => "alert #{bootstrap_class_for(type.to_sym)} alert-dismissable text-center container mt-5 mb-2 rounded fade show") do
          concat content_tag(:button, "&times;".html_safe, :class => "close", :data => { :dismiss => "alert" })
          concat content_tag(:strong, message)
        end
      )
    end

    nil
  end

  def render_page_data
    @page_data.html_safe if @page_data.present?
  end

  def page_data(options = {})
    @page_data = ""

    options.each do |key, value|
      @page_data << "data-#{key.to_s.tr("_", "-")}=\"#{value}\" "
    end

    @page_data
  end

end
