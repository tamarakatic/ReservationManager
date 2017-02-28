# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on("turbolinks:load", ready)

ready = ->
  initializeDatetimePicker()
  createSeatsMap($("#restaurant-seats").data("temp"))
  bindHandlers()

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

initializeDatetimePicker = ->
  savedDate = []
  if loadData("reservation-date")
    savedDate = moment(new Date(loadData("reservation-date"))).format("D MMMM, YYYY")
  else
    savedDate = moment(new Date()).format("D MMMM, YYYY")

  $("#reservation-date").val(savedDate).pickadate({
    min:       new Date(),      # Current date is minimal
    firstDay:  1,               # Monday as first day
    onSet: (context) ->
      storeData("reservation-date", context.select)
  })

  $("#reservation-time").pickatime({
    format:    "HH:i",
    interval:  30,
    min:       [8, 0],
    max:       [22, 0],
    onSet: (context) ->
      storeData("reservation-time", context.select)
  }).val( () ->
    time = loadData("reservation-time") || 8 * 60

    hours   = Math.floor(time / 60)
    minutes = time % 60
    hours   = if hours < 10 then '0' + hours else hours
    minutes = if minutes < 10 then '0' + minutes else minutes

    "#{hours}:#{minutes}"
  )

  storeData("reservation-duration", $("#reservation-duration").val())
  $("#reservation-duration").on "input", (e) ->
    storeData("reservation-duration", $(this).val())

  $("#date-step").unbind("click").bind "click", (e) ->
    if loadData("reservation-duration") > 0 and loadData("reservation-duration") <= 3
      $("#select-table").removeAttr("hidden")
      $("#date-hr").removeAttr("hidden")
      $(this).text("Refresh")
      $(this).switchClass("btn-success", "btn-warning")
      $(this).unbind("click").bind("click", updateAvailableSeats)
    else
      alert("Reservation duration must be more thatn 0 and less than 3 hours!")
      $("#reservation-duration").val(0.5)
      return false
    e.preventDefault()

updateAvailableSeats = (event) ->
  date     = loadData("reservation-date")
  time     = loadData("reservation-time")
  duration = loadData("reservation-duration")

  $.ajax "/customers/reservations/available_tables",
    type: "GET",
    data: { restaurant_id: $("#restaurant-seats").data("restaurant") }
    success: () ->
      console.log "hello"

  event.preventDefault()

storeData = (key, value) ->
  sessionStorage.setItem(key, JSON.stringify(value))

loadData = (key) ->
  JSON.parse(sessionStorage.getItem(key))

