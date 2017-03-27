module HomePage::CustomerHomeHelper

  def restaurant_markers
    content_tag(:div, "", :id => "restaurant-markers", :data => { :markers => @markers })
  end

end
