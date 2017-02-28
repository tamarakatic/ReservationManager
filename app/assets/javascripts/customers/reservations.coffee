# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on("turbolinks:load", ready)

ready = ->
  # Restaurant tabel data
  restaurantSeats = $("#restaurant-seats").data("temp")
  createSeatsMap(restaurantSeats)

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

initializeSeatMap = (map, rowLabels) ->
  $("#seat-map").seatCharts {
    animate: true,
    naming: {
      top: false
      rows: rowLabels
    },
    map: map,
    legend: {
      node: $('#legend'),
      items: [
          [ "a", "available",   "Available tables" ],
          [ "a", "unavailable", "Reserved tables" ]
      ]
    },
    click: ->
      selectedTables = []
      unless loadData("tables")
        storeData("tables", [])
      else
        selectedTables = loadData("tables")

      if this.status() == 'available'
          selectedTables.push(this.node()[0].id)
          storeData("tables", selectedTables)
          return "selected"
      else if this.status() == 'selected'
          selectedTables = _.without(selectedTables, this.node()[0].id)
          storeData("tables", selectedTables)
          return "available"
      else if this.status() == "unavailable"
          return "unavailable"
      else
          return this.style()
  }

createSeatsMap = (restaurantSeats) ->
  seatMap = []
  rows = []

  for area in restaurantSeats
    rows.push(area.area)
    seatMap.push(_.reduce(area.tables, (acc, table) ->
      "#{acc}a[#{area.id}_#{table.id}, #{table.seatstable}]"
    , ""))

  initializeSeatMap(seatMap, rows)

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

