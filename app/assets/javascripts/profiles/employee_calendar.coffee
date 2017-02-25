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
