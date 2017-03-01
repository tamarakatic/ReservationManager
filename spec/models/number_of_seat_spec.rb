require 'rails_helper'

RSpec.describe NumberOfSeat, type: :model do
  describe "Associations" do
    it { should belong_to(:seat) }
    it { should have_many(:reservations) }
    it { should have_many(:reserved_tables) }
  end
end
