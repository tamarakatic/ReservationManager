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
        expect(:manager).to be_valid
      end
    end
  end
end
