require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe "Associations" do
    it {should belong_to(:provider) }
    it {should belong_to(:restaurant) }
  end

  describe "Validations" do
    let!(:offer) {create(:offer, start_at: "2016-12-21 13:46:37") }

    context "with valid attributes" do
      it "is valid" do
        expect(offer).to be_valid
      end
    end

    context "with start_at already taken" do
      it 'is invalid' do
        expect { create(:offer, start_at: "2016-12-21 13:46:37") }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context "with missing start_at" do
      it "is invalid" do
        offer.start_at = nil
        expect(offer).to_not be_valid
      end
    end

    context "with missing end_at" do
      it "is invalid" do
        offer.end_at = nil
        expect(offer).to_not be_valid
      end
    end

    context "with blank start_at" do
      it "is invalid" do
        offer.start_at = '    '
        expect(offer).to_not be_valid
        expect(offer.errors[:start_at]).to include("can't be blank")
      end
    end

    context "with blank start_at" do
      it "is invalid" do
        offer.end_at = '    '
        expect(offer).to_not be_valid
        expect(offer.errors[:end_at]).to include("can't be blank")
      end
    end

  end
end
