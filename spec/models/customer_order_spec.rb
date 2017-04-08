require "rails_helper"

RSpec.describe CustomerOrder, type: :model do
  subject { FactoryGirl.create(:customer_order) }

  describe "associations" do
    it { should have_many(:customer_order_drinks).dependent(:destroy) }
    it { should have_many(:customer_order_foods).dependent(:destroy) }
    it { should have_many(:customer_order_seats).dependent(:destroy) }

    it { should have_many(:drinks).through(:customer_order_drinks) }
    it { should have_many(:foods).through(:customer_order_foods) }
    it { should have_many(:number_of_seats).through(:customer_order_seats) }

    it { should have_many(:serving_times).dependent(:destroy) }
    it { should have_many(:customer_order_parts).dependent(:destroy) }

    it { should have_many(:reservation_orders).dependent(:destroy) }
    it { should have_many(:reservations).through(:reservation_orders) }

    it { should belong_to(:customer) }
  end

  describe "#any_orders_left?" do
    let(:steak) { FactoryGirl.create(:food, :name => "Steak") }
    let(:vine)  { FactoryGirl.create(:drink, :name => "Vine",
                                             :restaurant => steak.restaurant) }

    context "given there are no food or dring orders" do
      it "returns false do" do
        expect(subject.any_orders_left?).to be_falsy
      end
    end

    context "given there are food orders" do
      before do
        subject.customer_order_foods.create(:food => steak)
      end

      it "returns true" do
        expect(subject.any_orders_left?).to be_truthy
      end
    end

    context "given there are drink orders" do
      before do
        subject.customer_order_drinks.create(:drink => vine)
      end

      it "returns true" do
        expect(subject.any_orders_left?).to be_truthy
      end
    end

    context "given there are drink and food orders" do
      before do
        subject.customer_order_foods.create(:food => steak)
        subject.customer_order_drinks.create(:drink => vine)
      end

      it "returns true" do
        expect(subject.any_orders_left?).to be_truthy
      end
    end
  end
end
