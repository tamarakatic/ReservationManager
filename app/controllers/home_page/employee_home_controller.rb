module HomePage
  class EmployeeHomeController < ApplicationController
    before_action :authenticate_employee!

    def index
    end
  end
end
