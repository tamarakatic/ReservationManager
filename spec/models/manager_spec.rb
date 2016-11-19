require 'rails_helper'

RSpec.describe Manager, type: :model do

  describe 'Associations' do
    it { should have_many(:employees).dependent(:destroy) }
    it { should have_many(:providers).dependent(:destroy) }
  end

  describe 'Validations' do
    let!(:manager) { build(:manager) }

    context 'with valid attributes' do
      it 'is valid' do
        expect(manager).to be_valid
      end
    end

    context 'with missing firstname' do
      it 'is invalid' do
        manager.firstname = nil
        expect(manager).to_not be_valid
      end
    end

    context 'with missing lastname' do
      it 'is invalid' do
        manager.lastname = nil
        expect(manager).to_not be_valid
      end
    end

    context 'with firstname too short' do
      it 'is invalid' do
        manager.firstname = 'A'
        expect(manager).to_not be_valid

        manager.firstname = 'John'
        expect(manager).to be_valid
      end
    end

    context 'with firstname too long' do
      it 'is invalid' do
        manager.firstname = 'John' * 8
        expect(manager).to_not be_valid

        manager.firstname = 'John'
        expect(manager).to be_valid
      end
    end

    context 'with lastname too short' do
      it 'is invalid' do
        manager.lastname = 'A'
        expect(manager).to_not be_valid

        manager.lastname = 'John'
        expect(manager).to be_valid
      end
    end

    context 'with lastname too long' do
      it 'is invalid' do
        manager.lastname = 'John' * 8
        expect(manager).to_not be_valid

        manager.lastname = 'John'
        expect(manager).to be_valid
      end
    end

    context 'with blank firstname' do
      it 'is invalid' do
        manager.firstname = '    '
        expect(manager).to_not be_valid
        expect(manager.errors[:firstname]).to include("can't be blank")
      end
    end

    context 'with blank lastname' do
      it 'is invalid' do
        manager.lastname = '    '
        expect(manager).to_not be_valid
        expect(manager.errors[:lastname]).to include("can't be blank")
      end
    end
  end
end
