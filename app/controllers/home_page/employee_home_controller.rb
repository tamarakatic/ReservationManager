module HomePage
  class EmployeeHomeController < ApplicationController
    before_filter :authenticate_employee!

    def index
    end
  end
end
