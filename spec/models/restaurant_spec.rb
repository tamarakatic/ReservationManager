require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'Associations' do
    it { should have_many(:drinks).dependent(:destroy) }
    it { should have_many(:foods).dependent(:destroy) }
    it { should have_many(:seats).dependent(:destroy) }
  end

  describe 'Validations' do
    let!(:restaurant) { create(:restaurant, title: 'Black Swan') }

    context 'with valid attributes' do
      it 'is valid' do
        expect(restaurant).to be_valid
      end
    end

    context 'with title already taken' do
      it 'is invalid' do
        expect { create(:restaurant, title: 'Black Swan') }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'with missing title' do
      it 'is invalid' do
        restaurant.title = nil
        expect(restaurant).to_not be_valid
      end
    end

    context 'with missing description' do
      it 'is invalid' do
        restaurant.description = nil
        expect(restaurant).to_not be_valid
      end
    end

    context 'with title too short' do
      it 'is invalid' do
        restaurant.title = 'A'
        expect(restaurant).to_not be_valid
      end
    end

    context 'with title too long' do
      it 'is invalid' do
        restaurant.title = 'Abcd' * 8
        expect(restaurant).to_not be_valid
      end
    end

    context 'with description too long' do
      it 'is invalid' do
        restaurant.description = 'Abcd' * 80
        expect(restaurant).to_not be_valid
      end
    end

    context 'with blank title' do
      it 'is invalid' do
        restaurant.title = '    '
        expect(restaurant).to_not be_valid
        expect(restaurant.errors[:title]).to include("can't be blank")
      end
    end

    context 'with blank description' do
      it 'is invalid' do
        restaurant.description = '    '
        expect(restaurant).to_not be_valid
        expect(restaurant.errors[:description]).to include("can't be blank")
      end
    end
  end
end
