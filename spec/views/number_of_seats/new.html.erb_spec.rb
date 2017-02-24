require 'rails_helper'

RSpec.describe "number_of_seats/new", type: :view do
  before(:each) do
    assign(:number_of_seat, NumberOfSeat.new())
  end

  it "renders new number_of_seat form" do
    render

    assert_select "form[action=?][method=?]", number_of_seats_path, "post" do
    end
  end
end
