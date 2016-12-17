module HomePage
  class CustomerHomeController < ApplicationController
    before_action :authenticate_customer!

    def index
    end

  end
end
