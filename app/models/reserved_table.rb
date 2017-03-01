class ReservedTable < ApplicationRecord
  belongs_to :reservation
  belongs_to :number_of_seat

  alias_attribute :table, :number_of_seat
end
