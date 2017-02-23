class Employee < ApplicationRecord
  belongs_to :manager

  enum clothing_size: %w(XS S M L XL XXL)

  validates :firstname, length: { in: 3..30 },
                        allow_blank: false,
                        presence: true

  validates :lastname, length: { in: 3..30 },
                       allow_blank: false,
                       presence: true

  validates :shoe_size, numericality: { greater_than_or_equal_to: 35,
                                        less_than_or_equal_to: 49 },
                        allow_blank: false,
                        presence: true

  validates :birth_date, date: { before: 18.years.ago,
                                 before_message: 'must be at least 18 years old' },
                         allow_blank: false,
                         presence: true

  validate :speciality_validator

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.types
    %w(Bartender Cook Waiter)
  end

  private

  def speciality_validator
    return if type.nil?
    unless type == 'Cook'
      errors.add(:speciality, "can be assign only to cooks.") unless speciality.nil?
    else
      errors.add(:speciality, "can't be blank.") if speciality.blank?
    end
  end
end
