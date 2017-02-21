class HomePage::ProviderHomeController < ApplicationController
  before_action :authenticate_provider!
  before_action :check_if_password_changed

  layout "home_page"

  def index
  end

  private

  def check_if_password_changed
    unless current_provider.password_changed
      redirect_to edit_provider_registration_path(current_provider)
    end
  end

end
