class HomePage::ManagerHomeController < ApplicationController
  before_action :authenticate_manager!

  layout "home_page"

  def index
  end
end
