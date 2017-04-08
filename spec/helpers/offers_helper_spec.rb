require "rails_helper"

RSpec.describe OffersHelper, type: :helper do

  describe ".offer_price" do
    let(:offer_item) { double "offer_item" }

    before do
      allow(OfferItem).to receive_message_chain(:where, :first) { offer_item }
      allow(offer_item).to receive(:price) { 23 }
    end

    it "returns offer item price" do
      expect(offer_price(42)).to eql 23
    end
  end

  describe ".datepicker_time" do
    it "returns time formated for jquery datepicker" do
      formatted_date = DateTime.now.noon.utc.iso8601.gsub("Z", "")

      expect(datepicker_time(DateTime.now.noon)).to eql formated_date
    end
  end
end
