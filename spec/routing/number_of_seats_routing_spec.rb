require "rails_helper"

RSpec.describe NumberOfSeatsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/number_of_seats").to route_to("number_of_seats#index")
    end

    it "routes to #new" do
      expect(:get => "/number_of_seats/new").to route_to("number_of_seats#new")
    end

    it "routes to #show" do
      expect(:get => "/number_of_seats/1").to route_to("number_of_seats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/number_of_seats/1/edit").to route_to("number_of_seats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/number_of_seats").to route_to("number_of_seats#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/number_of_seats/1").to route_to("number_of_seats#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/number_of_seats/1").to route_to("number_of_seats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/number_of_seats/1").to route_to("number_of_seats#destroy", :id => "1")
    end

  end
end
