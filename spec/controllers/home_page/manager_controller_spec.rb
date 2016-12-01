require 'rails_helper'

RSpec.describe HomePage::ManagerHomeController, type: :controller do

  describe "GET #index" do
    login_user(:manager)

    it "returns http success" do
      p subject.current_manager
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
