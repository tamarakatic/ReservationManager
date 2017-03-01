class ReservedTable < ApplicationRecord
  belongs_to :reservation
  belongs_to :number_of_seat

  alias_attribute :table, :number_of_seat

  validates :duration, :presence => true,
                       :numericality => { :greater_than_or_equal_to => 0.1 }

  validates :date, :presence => true,
                   :timeliness => { :on_or_after => lambda { DateTime.current },
                                    :type => :date }
end
