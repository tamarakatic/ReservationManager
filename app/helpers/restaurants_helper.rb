module RestaurantsHelper

  def managers_information
    @managers.reject { |m| !m.confirmed? }.collect { |m| ["#{m.firstname} #{m.lastname}", m.id] }
  end
  
end
