# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->
    $('#calendar_employee').fullCalendar({
      editable: false,
      slotEventOverlap: false,
      buttonText: {
        today: 'Today',
        month: 'Month',
        week: 'Week',
        day: 'Day'
      },
      events: (start, end, timezone, callback) ->
        employee_shift_load(callback)
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

    $('#employee').change ->
      employee = document.getElementById('employee')
      employee_type = employee.options[employee.selectedIndex].text.split(' ')[2]
      if(employee_type == 'Waiter')
        $('#role').show()
        $('#area').show()
      else
        $('#role').hide()
        $('#area').hide()

    $('#employeeUpdate').change ->
      employee = document.getElementById('employeeUpdate')
      employee_type = employee.options[employee.selectedIndex].text.split(' ')[2]
      if(employee_type == 'Waiter')
        $('#areaUpdate').show()
        $('#roleUpdate').show()
      else
        $('#areaUpdate').hide()
        $('#roleUpdate').hide()


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
    employee = document.getElementById('employee')
    employee_id = employee.options[employee.selectedIndex].value
    name_surname = employee.options[employee.selectedIndex].title

    startTime = timeConvert($('#startTime').val())
    endTime = timeConvert($('#endTime').val())
    type = document.getElementById('role')
    role = type.options[type.selectedIndex].value
    dat = moment(date).format('YYYY-MM-DD')
    start = new Date(dat+"T"+startTime)
    end = new Date(dat+"T"+endTime)

    console.log(start)
    console.log(end)

    if employee_id == '' || startTime == '' || endTime == ''
      return

    $.ajax
      url: "/employee_shifts"
      type: 'POST'
      dataType: 'json'
      data: { employee_id: employee_id, start_at: startTime, end_at: endTime, role: role, current_date: dat }
      success: (response) ->
        console.log(response)
        startT = response.shift.start_at.split('T')[1]
        endT = response.shift.end_at.split('T')[1]
        event = {
          title: response.employee.firstname + " " + response.employee.lastname,
          start: new Date(response.shift.work_day+"T"+startT),
          end: new Date(response.shift.work_day+"T"+endT)
          allDay: false
        }
        $('#calendar_employee').fullCalendar 'renderEvent', event, true


    $('#employee :selected').text()
    $('#startTime').val('')
    $('#endTime').val('')
    $('#role :selected').text()
    $('#eventModal').modal 'hide'

updateShift = (event) ->
  $('#updateShift').unbind("click").click (e) ->
    employee = document.getElementById('employeeUpdate')
    employee_id = employee.options[employee.selectedIndex].value
    name_surname = employee.options[employee.selectedIndex].title
    console.log(name_surname)
    startTime = timeConvert($('#startTimeUpdate').val())
    endTime = timeConvert($('#endTimeUpdate').val())
    type = document.getElementById('roleUpdate')
    role = type.options[type.selectedIndex].value
    event.title = name_surname
    datum = moment(event.start).format('YYYY-MM-DD')
    event.start = new Date(datum+"T"+startTime)
    event.end = new Date(datum+"T"+endTime)
    if employee_id == '' || startTime = '' || endTime = ''
      return
    $('#calendar_employee').fullCalendar('updateEvent', event)
    $('#employeeUpdate :selected').text()
    $('#startTimeUpdate').val('')
    $('#endTimeUpdate').val('')
    $('#roleUpdate :selected').text()
    $('#eventModalUpdate').modal 'hide'

fillModal = (event) ->
  $('employeeUpdate').filter(->
    $(this).text() == event.title
  ).prop 'selected', true
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

employee_shift_load = (callback)->
  $.ajax
    url: "/employee_shifts"
    type: 'GET'
    dataType: 'json'
    success: (response) ->
      console.log(response)
      eventsArray = []
      for x of response.employee
        startT = response.shift[x].start_at.split('T')[1]
        endT = response.shift[x].end_at.split('T')[1]
        event = {
          title: response.employee[x].firstname + " " + response.employee[x].lastname,
          start: new Date(response.shift[x].work_day+"T"+startT),
          end: new Date(response.shift[x].work_day+"T"+endT)
          allDay: false
        }
        eventsArray.push(event)
      callback(eventsArray)
