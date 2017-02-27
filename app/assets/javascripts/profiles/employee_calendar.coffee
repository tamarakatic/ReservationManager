# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->
    $('#calendar').fullCalendar({
      editable: false,
      slotEventOverlap: false,
      buttonText: {
        today: 'Today',
        month: 'Month',
        week: 'Week',
        day: 'Day'
      },
      events: (start, end, timezone, callback) ->
        fillCalendar(callback)
      minTime: "00:00:00",
      maxTime: "23:59:00",
      header: {
        left: 'prev,next, today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      timeFormat: 'h:mm a',
      dragOpacity: "0.5"
    });


fillCalendar = (callback) ->
  $.ajax
    url: '/profiles/employee_calendar'
    type: 'GET'
    dataType: 'json'
    success: (data) ->
      eventsArray = []
      console.log(data)
      for x of data.shift
        startT = data.shift[x].start_at.split('T')[1]
        endT = data.shift[x].end_at.split('T')[1]
        event = {
          title: data.title,
          start: new Date(data.shift[x].work_day+"T"+startT),
          end: new Date(data.shift[x].work_day+"T"+endT),
          allDay: false
        }
        eventsArray.push(event)
      callback(eventsArray)