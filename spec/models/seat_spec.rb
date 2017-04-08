require "rails_helper"

RSpec.describe Seat, type: :model do
  describe "Associations" do
    it { should belong_to(:restaurant) }
    it { should have_many(:number_of_seats) }
    it { should have_many(:employee_shifts) }
  end

  describe "Attributes" do
    it { should validate_presence_of(:area) }
    it { should_not allow_value("", " ", nil).for(:area) }
    it { should validate_length_of(:area).is_at_least(2) }
    it { should validate_length_of(:area).is_at_most(30) }
  end

  describe "#as_json" do
    subject { FactoryGirl.create(:seat).as_json }

    it { should be_instance_of(Hash) }
    it { should include "id" }
    it { should include "tables" }
    it { should include "area" }
    it { should include "created_at" }
  end
end
