class Shift < ApplicationRecord
  has_many :employee_shifts

  validates :work_day, allow_blank: false,
                       presence: true

  validates :start_at, allow_blank: false,
                       presence: true

  validates :end_at, allow_blank: false,
                     presence: true

end
