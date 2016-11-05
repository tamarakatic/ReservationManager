class Restaurant < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :drinks, dependent: :destroy
  has_many :seats, dependent: :destroy

  validates_presence_of :title, :description

  validates :title,
    uniqueness: true,
    length: { in: 2..30 },
    allow_blank: false

  validates :description,
    length: { maximum: 300 },
    allow_blank: false
end
