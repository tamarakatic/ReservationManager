require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "Associations" do
    it { should belong_to(:restaurant) }
    it { should belong_to(:customer) }
    it { should have_many(:reservation_invitations) }
    it { should have_many(:number_of_seats) }
  end

  describe "validations" do
    let!(:reservation) { build(:reservation) }

    context "when reservation end date is after begin date" do
      it "is valid" do
        expect(reservation).to be_valid
      end
    end

    context "when end of reservation date is lower than begin date" do
      before do
        reservation.reserved_to = reservation.reserved_from - 5.hours
      end

      it "is invalid" do
        expect(reservation).to_not be_valid
      end
    end

    context "when reservation day is in past" do
      before do
        reservation.reserved_from = DateTime.now - 5.days
      end

      it "is invaid" do
        expect(reservation).to_not be_valid
      end
    end
  end
end
