require 'rails_helper'

RSpec.describe "number_of_seats/edit", type: :view do
  before(:each) do
    @number_of_seat = assign(:number_of_seat, NumberOfSeat.create!())
  end

  it "renders the edit number_of_seat form" do
    render

    assert_select "form[action=?][method=?]", number_of_seat_path(@number_of_seat), "post" do
    end
  end
end
