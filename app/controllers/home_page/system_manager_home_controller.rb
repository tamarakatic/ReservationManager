class HomePage::SystemManagerHomeController < ApplicationController
  before_action :authenticate_system_manager!

  def index
  end
end
