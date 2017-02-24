# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->
  $ ->
    $('#start').datepicker()

  $ ->
    $('#end').datepicker()

  $ ->
    $('#startTime').timepicker({
      minTime: '00:00am',
      maxTime: '23:59pm',
      interval: 5,
      dynamic: false,
      dropdown: true,
      scrollbar: true
    })

  $ ->
    $('#endTime').timepicker()

  $('#SaveShift').click ->
    firstname = $('#firstname').val()
    lastname = $('#lastname').val()
    startDate = $('#start').val()
    endDate = $('#end').val()
    startTime = $('#startTime').val()
    endTime = $('#endTime').val()
    console.log(firstname)
    console.log(lastname)
    console.log(startDate)
    console.log(endDate)
    console.log(startTime)
    console.log(endTime)
    $('#eventModal').modal 'hide'


  startTime = new Date("2017-02-22T08:00:00")
  endTime = new Date("2017-02-22T17:00:00")
  myEvent = {
    allDay: false,
    title: 'Sanker smena',
    start: startTime,
    end: endTime
  };

  $('#calendar').fullCalendar({
    editable: false,
    slotEventOverlap: false,
    buttonText: {
      today: 'Today',
      month: 'Month',
      week: 'Week',
      day: 'Day'
    },
    minTime: "00:00:00",
    maxTime: "23:59:00",
    dayClick: (event, element, view) ->
        $('#eventModal').modal 'show'
    header: {
      left: 'prev,next, today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    timeFormat: 'h:mm',
    dragOpacity: "0.5",
  });

