# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).ready(ready)
  $(document).on("turbolinks:load", ready)

ready = ->
  $('#seat-map').seatCharts {
    animate: true,
    naming: {
      left: false,
      top: false,
    },
    map: [
        'aaa_aaa_aaa',
        'aaa_aaa_aaa',
        'aaa_aaa_aaa',
        'aaa_aaa_aaa',
        'aaa_aaa_aaa',
        'aaa_aaa_aaa',
    ],
    legend: {
      node: $('#legend'),
      items: [
          [ "a", "available",   "Available tables" ],
          [ "a", "unavailable", "Reserved tables" ]
      ]
    },
    seats: {
        a: {
            classes : 'front-seat'
        }
    },
    click: ->
      if this.status() == 'available'
          return 'selected'
      else if this.status() == 'selected'
          # seat has been vacated
          return 'available'
      else if this.status() == 'unavailable'
          # seat has been already booked
          return 'unavailable'
      else
          return this.style()
  }
