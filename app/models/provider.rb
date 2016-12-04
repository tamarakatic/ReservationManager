class Provider < ApplicationRecord
  belongs_to :manager

  validates :firstname, presence: true,
                        length: { in: 2..30 },
                        allow_blank: false

  validates :lastname, presence: true,
                       length: { in: 2..30 },
                       allow_blank: false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end