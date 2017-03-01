class HomePage::ManagerHomeController < ApplicationController
  before_action :authenticate_manager!

  layout "manager_profile"

  def index
  end

  def list_provider
    respond_to do |format|
      format.html { render :providers }
    end
  end

  def list_order
    respond_to do |format|
      format.html { render :orders }
    end
  end

  def list_offer
    respond_to do |format|
      format.html { render :offers }
    end
  end

end
