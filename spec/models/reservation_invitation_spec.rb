require 'rails_helper'

RSpec.describe ReservationInvitation, type: :model do
  describe "Associations" do
    it { should belong_to(:reservation) }
    it { should belong_to(:customer) }
  end
end
