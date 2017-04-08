require "rails_helper"

RSpec.describe Reservation, type: :model do
  subject { FactoryGirl.create(:reservation, :reserved_from => Time.now + 1.hours,
                                             :reserved_to   => Time.now + 2.hours) }

  it { should belong_to(:restaurant) }
  it { should belong_to(:customer) }
  it { should have_many(:reservation_invitations).dependent(:destroy) }
  it { should have_many(:reserved_tables).dependent(:destroy) }
  it { should have_many(:number_of_seats).through(:reserved_tables) }
  it { should have_many(:reservation_orders) }
  it { should have_many(:customer_orders).through(:reservation_orders).dependent(:destroy) }

  describe "attributes" do
    it { should respond_to(:host) }
    it { should respond_to(:invitations) }
    it { should respond_to(:tables) }
  end

  describe "validations" do

    context "when reservation end date is after begin date" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "when end of reservation date is lower than begin date" do
      before do
        subject.reserved_to = subject.reserved_from - 5.hours
      end

      it "is invalid" do
        expect(subject).to_not be_valid
      end
    end

    context "when reservation day is in past" do
      before do
        subject.reserved_from = DateTime.now - 5.days
      end

      it "is invaid" do
        expect(subject).to_not be_valid
      end
    end
  end

  describe "#acitve?" do
    context "when reservation start date is after current time" do
      before do
        subject.reserved_from = Time.now + 1.hour
      end

      it "returns true" do
        expect(subject.active?).to be_truthy
      end
    end

    context "when reservation start date is before current time" do
      before do
        subject.reserved_from = Time.now - 1.hour
      end

      it "returns false" do
        expect(subject.active?).to be_falsy
      end
    end
  end

  describe "#cancelable?" do
    context "when there is more than 30 minutes from reservation start" do
      before do
        subject.reserved_from = Time.now + 1.hour
      end

      it "returns true" do
        expect(subject.cancelable?).to be_truthy
      end
    end

    context "when there is less than 30 minutes from reservation start" do
      before do
        subject.reserved_from = Time.now + 29.minutes
      end

      it "returns false" do
        expect(subject.cancelable?).to be_falsy
      end
    end
  end

  describe "#duration_in_hours" do
    context "given start time is 12:00 and end time is 13:00" do
      before do
        subject.reserved_from = DateTime.now.noon
        subject.reserved_to   = DateTime.now.noon + 1.hour
      end

      it "returns 1 hour" do
        expect(subject.duration_in_hours).to eql 1.0
      end
    end
  end
end
