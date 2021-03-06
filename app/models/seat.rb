class Seat < ApplicationRecord
  belongs_to :restaurant

  has_many :number_of_seats
  has_many :employee_shifts

  validates :area, :presence => true,
                   :allow_blank => false,
                   :length => { :in => 2..30 }

  def as_json(options = {})
    super.as_json.merge("tables" => self.number_of_seats)
  end
end
