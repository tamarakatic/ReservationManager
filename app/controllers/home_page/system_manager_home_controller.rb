class HomePage::SystemManagerHomeController < ApplicationController
  before_filter :authenticate_system_manager!

  def index
  end
end
