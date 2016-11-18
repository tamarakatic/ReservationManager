require 'rails_helper'

RSpec.describe Food, type: :model do

  describe "Associations" do
    it {should belong_to(:restaurant) }
  end

  describe "Validations" do
      let!(:food) { create(:food, :name => "Salata") }

      context "with valid attributes" do
        it "is valid" do
          expect(food).to be_valid
        end
      end

      context "with negative price" do
        it "is invalid" do
          food.price = -1
          expect(food).to_not be_valid
        end
      end

      context "with name already taken" do
        it "is invalid" do
          expect { create(:food, :name => "Salata") }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context "with missing name" do
        it "is invalid" do
          food.name = nil
          expect(food).to_not be_valid
        end
      end

      context "with name too short" do
        it "is invalid" do
          food.name = "A"
          expect(food).to_not be_valid
        end
      end

      context "with name too long" do
        it "is invalid" do
          food.name = "Abcd" * 8
          expect(food).to_not be_valid
        end
      end

      context "with description too long" do
        it "is invalid" do
          food.description = "Abcd" * 80
          expect(food).to_not be_valid
        end
      end
    end
  end
