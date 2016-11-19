require 'rails_helper'

RSpec.describe Drink, type: :model do
  describe 'Associations' do
    it { should belong_to(:restaurant) }
  end

  describe 'Validations' do
    let!(:drink) { build(:drink, name: 'Vodka') }

    context 'with valid attributes' do
      it 'is valid' do
        expect(drink).to be_valid
      end
    end

    context 'with negative price' do
      it 'is invalid' do
        drink.price = -1
        expect(drink).to_not be_valid
      end
    end

    context 'with name already taken' do
      it 'is invalid' do
        expect { create(:drink, name: 'Vodka') }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'with missing name' do
      it 'is invalid' do
        drink.name = nil
        expect(drink).to_not be_valid
      end
    end

    context 'with name too short' do
      it 'is invalid' do
        drink.name = 'A'
        expect(drink).to_not be_valid
      end
    end

    context 'with name too long' do
      it 'is invalid' do
        drink.name = 'Abcd' * 8
        expect(drink).to_not be_valid
      end
    end

    context 'with description too long' do
      it 'is invalid' do
        drink.description = 'Abcd' * 80
        expect(drink).to_not be_valid
      end
    end

    context 'with blank name' do
      it 'is invalid' do
        drink.name = '    '
        expect(drink).to_not be_valid
        expect(drink.errors[:name]).to include("can't be blank")
      end
    end

    context 'with blank description' do
      it 'is invalid' do
        drink.description = '    '
        expect(drink).to_not be_valid
        expect(drink.errors[:description]).to include("can't be blank")
      end
    end
  end
end
