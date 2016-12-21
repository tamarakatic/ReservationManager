class HomePage::ProviderHomeController < ApplicationController
  before_action :authenticate_provider!

  def index
  end
end
