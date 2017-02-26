class Shift < ApplicationRecord
  has_many :employee_shifts

  validates :work_day, date: { before: Date.current,
                               before_message: 'must be greater then today date' },
                       allow_blank: false,
                       presence: true

  validates :start_at, allow_blank: false,
                       presence: true

  validates :end_at, allow_blank: false,
                     presence: true

end
