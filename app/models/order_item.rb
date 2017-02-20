class OrderItem < ApplicationRecord
  belongs_to :order

  validates :item, length: { in: 2..40 },
                   presence: true,
                   allow_blank: false

  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 0.01 }

  validates :unit_of_measure, length: { in: 1..10 },
                              presence: true,
                              allow_blank: false

end
