require 'rails_helper'

RSpec.describe SystemManager, type: :model do

  describe 'Validations' do
    let!(:system_manager) { create(:system_manager) }

    context 'with valid attributes' do
      it 'is valid' do
        expect(system_manager).to be_valid
      end
    end

    context 'with missing firstname' do
      it 'is invalid' do
        system_manager.firstname = nil
        expect(system_manager).to_not be_valid
      end
    end

    context 'with missing lastname' do
      it 'is invalid' do
        system_manager.lastname = nil
        expect(system_manager).to_not be_valid
      end
    end

    context 'with firstname too short' do
      it 'is invalid' do
        system_manager.firstname = 'Z'
        expect(system_manager).to_not be_valid

        system_manager.firstname = 'Zika'
        expect(system_manager).to be_valid
      end
    end

    context 'with firstname too long' do
      it 'is invalid' do
        system_manager.firstname = 'Zika' * 8
        expect(system_manager).to_not be_valid

        system_manager.firstname = 'Zika'
        expect(system_manager).to be_valid
      end
    end

    context 'with lastname too short' do
      it 'is invalid' do
        system_manager.lastname = 'A'
        expect(system_manager).to_not be_valid

        system_manager.lastname = 'Zikic'
        expect(system_manager).to be_valid
      end
    end

    context 'with lastname too long' do
      it 'is invalid' do
        system_manager.lastname = 'Zikic' * 8
        expect(system_manager).to_not be_valid

        system_manager.lastname = 'Zikic'
        expect(system_manager).to be_valid
      end
    end

    context 'with blank firstname' do
      it 'is invalid' do
        system_manager.firstname = '   '
        expect(system_manager).to_not be_valid
        expect(system_manager.errors[:firstname]).to include("can't be blank")
      end
    end

    context 'with blank lastname' do
      it 'is invalid' do
        system_manager.lastname = '   '
        expect(system_manager).to_not be_valid
        expect(system_manager.errors[:lastname]).to include("can't be blank")
      end
    end
  end
end
