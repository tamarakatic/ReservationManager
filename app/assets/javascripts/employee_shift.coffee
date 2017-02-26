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
      dayClick: (date, element, view) ->
        saveShift(date)
        $('#eventModal').modal 'show'
      header: {
        left: 'prev,next, today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      eventClick: (event, element) ->
        $('#eventModalUpdate').modal 'show'
        fillModal(event)
        updateShift(event)
      timeFormat: 'h:mm a',
      dragOpacity: "0.5"
    });


    $('#startTime').timepicker({
      minTime: '00:00am',
      maxTime: '23:59pm',
      interval: 5,
      dynamic: false,
      dropdown: true,
      scrollbar: true
    })

    $('#endTime').timepicker({
      minTime: '00:00am',
      maxTime: '23:59pm',
      interval: 5,
      dynamic: false,
      dropdown: true,
      scrollbar: true
    })

    $('#startTimeUpdate').timepicker({
      minTime: '00:00am',
      maxTime: '23:59pm',
      interval: 5,
      dynamic: false,
      dropdown: true,
      scrollbar: true
    })

    $('#endTimeUpdate').timepicker({
      minTime: '00:00am',
      maxTime: '23:59pm',
      interval: 5,
      dynamic: false,
      dropdown: true,
      scrollbar: true
    })

saveShift = (date) ->
  $('#SaveShift').unbind("click").click (e) ->
    console.log(date)
    firstname = $('#firstname').val()
    lastname = $('#lastname').val()

    startTime = timeConvert($('#startTime').val())
    endTime = timeConvert($('#endTime').val())
    dat = moment(date).format('YYYY-MM-DD')
    start = new Date(dat+"T"+startTime)
    end = new Date(dat+"T"+endTime)

    console.log(start)
    console.log(end)
    newEvent = {
      title: firstname+" "+lastname+" shift",
      allDay: false,
      start: start,
      end: end
    }
    if firstname == '' || lastname == '' || startTime == '' || endTime == ''
      return
    $('#calendar').fullCalendar 'renderEvent', newEvent, true
    $('#firstname').val('')
    $('#lastname').val('')
    $('#startTime').val('')
    $('#endTime').val('')
    $('#eventModal').modal 'hide'

updateShift = (event) ->
  $('#updateShift').unbind("click").click (e) ->
    firstname = $('#firstnameUpdate').val()
    lastname = $('#lastnameUpdate').val()
    startTime = timeConvert($('#startTimeUpdate').val())
    endTime = timeConvert($('#endTimeUpdate').val())
    event.title = firstname+" "+lastname+" shift"
    datum = moment(event.start).format('YYYY-MM-DD');
    event.start = new Date(datum+"T"+startTime)
    event.end = new Date(datum+"T"+endTime)
    if firstname == '' || lastname == '' || startTime = '' || endTime = ''
      return
    $('#calendar').fullCalendar('updateEvent', event)
    $('#firstnameUpdate').val('')
    $('#lastnameUpdate').val('')
    $('#startTimeUpdate').val('')
    $('#endTimeUpdate').val('')
    $('#eventModalUpdate').modal 'hide'

fillModal = (event) ->
  title = event.title.split(' ')
  $('#firstnameUpdate').val(title[0])
  $('#lastnameUpdate').val(title[1])
  startTimeFormat = event.start.format('hh:mma')
  endTimeFormat = event.end.format('hh:mma')
  $('#startTimeUpdate').val(startTimeFormat)
  $('#endTimeUpdate').val(endTimeFormat)

timeConvert = (time) ->
  finalTime = ''
  if time.indexOf('pm') != -1 or time.indexOf('12') != -1
    hmin = time.split(':')
    hours = parseInt(hmin[0])
    if time.indexOf('am') != -1
      hours = 0
    else
      hours += 12
    hmin[1] = hmin[1].substring(0, hmin[1].length - 2)
    finalTime = hours.toString()+":"+hmin[1]
    return finalTime
  finalTime = time.substring(0, time.length - 2)
