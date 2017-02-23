class Profiles::ManagerProfileController < ApplicationController
  before_action :authenticate_manager!

  def index
  end
end
