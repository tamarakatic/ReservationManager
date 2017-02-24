require 'rails_helper'

RSpec.describe "NumberOfSeats", type: :request do
  describe "GET /number_of_seats" do
    it "works! (now write some real specs)" do
      get number_of_seats_path
      expect(response).to have_http_status(200)
    end
  end
end
