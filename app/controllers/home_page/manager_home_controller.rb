module HomePage
  class ManagerHomeController < ApplicationController
    before_filter :authenticate_manager!

    def index
    end
  end
end
