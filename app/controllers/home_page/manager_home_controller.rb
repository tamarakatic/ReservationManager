module HomePage
  class ManagerHomeController < ApplicationController
    before_action :authenticate_manager!

    def index
    end
  end
end
