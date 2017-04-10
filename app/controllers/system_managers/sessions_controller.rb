class SystemManagers::SessionsController < Devise::SessionsController
  layout "landing_page"

  protected

  def after_sign_out_path_for(resource)
    new_system_manager_session_path
  end
end
