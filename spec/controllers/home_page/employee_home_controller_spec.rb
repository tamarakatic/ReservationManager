require 'rails_helper'

RSpec.describe HomePage::EmployeeHomeController, type: :controller do

  describe "GET #index" do
    login_user(:employee)

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
