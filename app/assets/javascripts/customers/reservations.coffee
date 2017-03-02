# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on("turbolinks:load", ready)

ready = ->
  storeData("tables", [])
  storeData("invited", [])
  storeData("ordered-foods", [])
  storeData("ordered-drinks", [])
  storeData("guest-ordered-foods", [])
  storeData("guest-ordered-drinks", [])

  initializeDatetimePicker()
  bindHandlers()

initializeSeatMap = (map, rowLabels) ->
  window.seatMap ||= $("#seat-map").seatCharts {
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
        table = this.node()[0].id.split("_")[1]
        selectedTables.push(table)
        storeData("tables", selectedTables)
        return "selected"
      else if this.status() == 'selected'
        table = this.node()[0].id.split("_")[1]
        selectedTables = _.without(selectedTables, table)
        storeData("tables", selectedTables)
        return "available"
      else if this.status() == "unavailable"
        return "unavailable"
      else
        return this.style()
  }

  window.seatMap.find('u').status("unavailable")

createSeatsMap = (areas) ->
  seatMap = []
  rows    = []

  for area in areas
    rows.push(area.name)
    seatMap.push(_.reduce(area.tables, (acc, table) ->
      "#{acc}#{table.symbol || 'a'}[#{area.id}_#{table.id}, #{table.seatstable}]"
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

  # Set correct button for invited friends from saved data in sessionStorage
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

 ##############################################################################

  $("a[name='order-food']").unbind("click").click (e) ->
    ordered = []
    unless loadData("ordered-foods")
      storeData("ordered-foods", [])
    else
      ordered = loadData("ordered-foods")

    if $(this).text() == "Cancel"
      ordered = _.without(ordered, $(this).attr("id"))
      $(this).text("Order")
      $(this).switchClass("btn-danger", "btn-success", 1000)
    else
      ordered.push($(this).attr("id"))
      $(this).text("Cancel")
      $(this).switchClass("btn-success", "btn-danger", 1000)

    e.preventDefault()
    storeData("ordered-foods", ordered)

  ordered = loadData("ordered-foods")
  $("a[name='order-food']").each (index) ->
    if _.contains(ordered, $(this).attr("id"))
      $(this).removeClass("btn-success")
      $(this).addClass("btn-danger")
      $(this).text("Cancel")
    else
      $(this).removeClass("btn-danger")
      $(this).addClass("btn-success")
      $(this).text("Order")

  $("a[name='order-drink']").unbind("click").click (e) ->
    ordered = []
    unless loadData("ordered-drinks")
      storeData("ordered-drinks", [])
    else
      ordered = loadData("ordered-drinks")

    if $(this).text() == "Cancel"
      ordered = _.without(ordered, $(this).attr("id"))
      $(this).text("Order")
      $(this).switchClass("btn-danger", "btn-success", 1000)
    else
      ordered.push($(this).attr("id"))
      $(this).text("Cancel")
      $(this).switchClass("btn-success", "btn-danger", 1000)

    e.preventDefault()
    storeData("ordered-drinks", ordered)

  ordered = loadData("ordered-drinks")
  $("a[name='order-drink']").each (index) ->
    if _.contains(ordered, $(this).attr("id"))
      $(this).removeClass("btn-success")
      $(this).addClass("btn-danger")
      $(this).text("Cancel")
    else
      $(this).removeClass("btn-danger")
      $(this).addClass("btn-success")
      $(this).text("Order")

  #############################################################################

  $("a[name='guest-order-food']").unbind("click").click (e) ->
    guestOrder = []
    unless loadData("guest-ordered-foods")
      storeData("guest-ordered-foods", [])
    else
      guestOrder = loadData("guest-ordered-foods")

    if $(this).text() == "Cancel"
      guestOrder = _.without(guestOrder, $(this).attr("id"))
      $(this).text("Order")
      $(this).switchClass("btn-danger", "btn-success", 1000)
    else
      guestOrder.push($(this).attr("id"))
      $(this).text("Cancel")
      $(this).switchClass("btn-success", "btn-danger", 1000)

    e.preventDefault()
    storeData("guest-ordered-foods", guestOrder)
    console.log loadData("guest-ordered-foods")

  guestOrder = loadData("guest-ordered-foods")
  $("a[name='guest-order-food']").each (index) ->
    if _.contains(guestOrder, $(this).attr("id"))
      $(this).removeClass("btn-success")
      $(this).addClass("btn-danger")
      $(this).text("Cancel")
    else
      $(this).removeClass("btn-danger")
      $(this).addClass("btn-success")
      $(this).text("Order")

  ##########################################################################

  $("a[name='guest-order-drink']").unbind("click").click (e) ->
    guestOrder = []
    unless loadData("guest-ordered-drinks")
      storeData("guest-ordered-drinks", [])
    else
      guestOrder = loadData("guest-ordered-drinks")

    if $(this).text() == "Cancel"
      guestOrder = _.without(guestOrder, $(this).attr("id"))
      $(this).text("Order")
      $(this).switchClass("btn-danger", "btn-success", 1000)
    else
      guestOrder.push($(this).attr("id"))
      $(this).text("Cancel")
      $(this).switchClass("btn-success", "btn-danger", 1000)

    e.preventDefault()
    storeData("guest-ordered-drinks", guestOrder)
    console.log loadData("guest-ordered-drinks")

  guestOrder = loadData("guest-ordered-drinks")
  $("a[name='guest-order-drink']").each (index) ->
    if _.contains(guestOrder, $(this).attr("id"))
      $(this).removeClass("btn-success")
      $(this).addClass("btn-danger")
      $(this).text("Cancel")
    else
      $(this).removeClass("btn-danger")
      $(this).addClass("btn-success")
      $(this).text("Order")

  $("#guest-create-order").unbind("click").click (e) ->
    $.ajax "/customers/reservations/orders",
      type: "POST",
      data: {
        reservation: $("#reservation").val(),
        orders: {
          foods:   loadData("guest-ordered-foods"),
          drinks:  loadData("guest-ordered-foods")
        }
      },
      success: (data) ->
        console.log data

  $("#create-reservation").unbind("click").click (e) ->
    dates = getReservationDates()

    $.ajax "/customers/reservations/create",
      type: "POST",
      data: {
        restaurant:  $("#restaurant-seats").data("restaurant"),
        start:       dates.start.valueOf(),
        end:         dates.end.valueOf(),
        tables:      loadData("tables"),
        friends:     loadData("invited"),
        orders: {
          foods:   loadData("ordered-foods"),
          drinks:  loadData("ordered-drinks")
        }
      },
      success: (data) ->
        console.log("success")

    e.preventDefault()

  $("#tables-step").unbind("click").on "click", (e) ->
    $("#invite-friends").removeAttr("hidden", true)
    $("#tables-step").attr("hidden", true)
    $("html, body").animate({
        scrollTop: $(".list-group").offset().top
    }, 2000)
    e.preventDefault()

  $("#menu-step").unbind("click").on "click", (e) ->
    $("#menu").removeAttr("hidden", true)
    $("#menu-step").attr("hidden", true)
    $("html, body").animate({
        scrollTop: $(".table").offset().top
    }, 2000)
    e.preventDefault()

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

  storeData("reservation-date", Date.parse($("#reservation-date").val()))

  $("#reservation-time").pickatime({
    format:    "HH:i",
    interval:  30,
    min:       [8, 0],
    max:       [22, 0],
    onSet: (context) ->
      storeData("reservation-time", context.select)
  }).val( () ->
    time = loadData("reservation-time") || 8 * 60
    storeData("reservation-time", time)

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
      $(this).text("Refresh")
      $(this).switchClass("btn-success", "btn-warning")
      $(this).unbind("click").bind("click", updateAvailableSeats)
      $.when(updateAvailableSeats(e)).then ->
        $("#select-table").removeAttr("hidden")
        $("#date-hr").removeAttr("hidden")
        $("html, body").animate({
            scrollTop: $("#legend").offset().top
        }, 2000)
    else
      alert("Reservation duration must be more thatn 0 and less than 3 hours!")
      $("#reservation-duration").val(0.5)
      return false
    e.preventDefault()

getReservationDates = ->
  date     = loadData("reservation-date")
  time     = loadData("reservation-time")
  duration = loadData("reservation-duration")

  reservation_start = moment(date).add(time, "minutes")
  reservation_end   = moment(date).add(time, "minutes").add(duration, "hours")

  {
    start:  reservation_start,
    end:    reservation_end
  }

updateAvailableSeats = (event) ->
  dates = getReservationDates()

  $.ajax "/customers/reservations/available_tables",
    type:     "GET",
    dataType: "json",
    data: {
      restaurant_id:     $("#restaurant-seats").data("restaurant"),
      reservation_start: dates.start.valueOf(),
      reservation_end:   dates.end.valueOf()
    },
    success: (response) ->
      areas = {}
      reserved = []

      putTable = (areas, table) ->
        if table.area_id of areas
          areas[table.area_id].tables.push(table)
        else
          areas[table.area_id] = {
            name:    table.area_name,
            id:      table.area_id,
            tables:  [table]
          }

      for table in response.available
        table.symbol = 'a'
        putTable(areas, table)

      for table in response.reserved
        reserved.push("#{table.area_id}_#{table.id}")
        table.symbol = 'u'
        putTable(areas, table)

      unless window.seatMap
        createSeatsMap(_.values(areas))
      else
        window.seatMap.status(reserved, "unavailable")

  event.preventDefault()

storeData = (key, value) ->
  sessionStorage.setItem(key, JSON.stringify(value))

loadData = (key) ->
  JSON.parse(sessionStorage.getItem(key))

