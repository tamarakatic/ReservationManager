# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on("ready turbolinks:load", ready)

ready = ->
  initializeSeatMap()
  bindHandlers()

  # Set correct button for invited friends
  invited = loadData("invited")
  $("a[name='invite']").each (index) ->
    if _.contains(invited, $(this).attr("id"))
      $(this).removeClass("btn-success")
      $(this).addClass("btn-danger")
      $(this).text("Cancel")
    else
      $(this).removeClass("btn-danger")
      $(this).addClass("btn-success")
      $(this).text("Invite")

initializeSeatMap = ->
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

bindHandlers = ->
  $("a[name='invite']").unbind("click").click (event) ->
    invited = []
    unless loadData("invited")
      storeData("invited", [])
    else
      invited = loadData("invited")

    if $(this).text() == "Cancel"
      invited = _.without(invited, $(this).attr("id"))
      $(this).text("Invite")
      $(this).switchClass("btn-danger", "btn-success", 1000)
    else
      invited.push($(this).attr("id"))
      $(this).text("Cancel")
      $(this).switchClass("btn-success", "btn-danger", 1000)

    event.preventDefault()
    storeData("invited", invited)

storeData = (key, value) ->
  sessionStorage.setItem(key, JSON.stringify(value))

loadData = (key) ->
  JSON.parse(sessionStorage.getItem(key))

