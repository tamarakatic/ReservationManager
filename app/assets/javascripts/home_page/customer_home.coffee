$(document).on "turbolinks:load", ->
  if $(document.body).data("page-name") == "customer_home"
    handler = Gmaps.build("Google")

    restaurant_markers = $("#restaurant-markers").data("markers")

    myLocation = {
      picture: {
        url:     "https://www.google.com/mapfiles/arrow.png",
        width:   32,
        height:  32
      }
    }

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        myLocation.lat          = position.coords.latitude
        myLocation.lng          = position.coords.longitude

        $.ajax "/restaurant_distances",
          type: "GET",
          data: {
            latitude: myLocation.lat,
            longitude: myLocation.lng,
            restaurants: _.map(restaurant_markers, (marker) ->
              marker.marker_title
            )
          },
          success: (distances) ->
            _.each(distances, (distance, restaurant) ->
              $("span##{restaurant}").text("#{distance} kms away")
            )

        myLocation.marker_title = "Your location"
        restaurant_markers.push(myLocation)
    else
      console.error "Can not get current position"

    handler.buildMap {
      provider: {
        maxZoom: 18,
        minZoom: 3
      },
      internal: { id: "google-map" }
      },
      () ->
        markers = handler.addMarkers restaurant_markers

        handler.bounds.extendWith markers
        handler.fitMapToBounds()
