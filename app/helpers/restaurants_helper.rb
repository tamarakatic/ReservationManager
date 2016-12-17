module RestaurantsHelper

  def managers_information
    @managers.collect { |m| ["#{m.firstname} #{m.lastname}", m.id] }
  end

end
