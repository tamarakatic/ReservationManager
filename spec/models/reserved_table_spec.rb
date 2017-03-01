require 'rails_helper'

RSpec.describe ReservedTable, type: :model do
  describe "Associations" do
    it { should belong_to(:reservation) }
    it { should belong_to(:number_of_seat) }
  end
end
