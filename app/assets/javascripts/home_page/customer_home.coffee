# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  handler = Gmaps.build('Google')
  handler.buildMap {
    provider: {
      maxZoom: 18,
      minZoom: 3
    },
    internal: { id: "google-map" }
    },
    () ->
      markers = handler.addMarkers($("#restaurant-markers").data("markers"))
      handler.bounds.extendWith(markers)
      handler.fitMapToBounds()
