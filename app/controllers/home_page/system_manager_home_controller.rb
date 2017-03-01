class HomePage::SystemManagerHomeController < ApplicationController
  before_action :authenticate_system_manager!

  layout "restaurant_home"

  def index
  end
end
