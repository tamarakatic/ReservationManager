# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#day_chart').click ->
    days_visits()

  $('#week_chart').click ->
    week_visits()

  $('#pick_date_from').pickadate({
    min: new Date(2016,3,20),
    max: new Date(Date.now)
  })

  $('#pick_date_to').pickadate({
    min: new Date(2016,3,20),
    max: new Date(Date.now)
  })

  $('#showDiv').click ->
    showDiv()

showDiv = ->
  document.getElementById('show_income').style.display = 'block'

days_visits = ->
  ctx = document.getElementById('canvas')
  a = 0.05
  b = 2
  scatterChart = new Chart(ctx,
  type: 'line'
  data :
    labels: [
      '07:00'
      '10:00'
      '13:00'
      '16:00'
      '19:00'
      '21:00'
      '24:00'
    ]
    datasets: [ {
      label: 'Visits of restaurant during day'
      fill: false
      lineTension: 0.1
      backgroundColor: 'rgba(75,192,192,0.4)'
      borderColor: 'rgba(75,192,192,1)'
      borderCapStyle: 'butt'
      borderDash: []
      borderDashOffset: 0.0
      borderJoinStyle: 'miter'
      pointBorderColor: 'rgba(75,192,192,1)'
      pointBackgroundColor: '#fff'
      pointBorderWidth: 1
      pointHoverRadius: 5
      pointHoverBackgroundColor: 'rgba(75,192,192,1)'
      pointHoverBorderColor: 'rgba(220,220,220,1)'
      pointHoverBorderWidth: 2
      pointRadius: 1
      pointHitRadius: 10
      data: [
        x = 1
          a * x ^ 2 + b * x * Math.random()
          a * x ^ 2 + b * x * Math.random()
          a * x ^ 2 + b * x * Math.random()
          a * x ^ 2 + b * x * Math.random()
          a * x ^ 2 + b * x * Math.random()
          a * x ^ 2 + b * x * Math.random()
          a * x ^ 2 + b * x * Math.random()
      ]
      spanGaps: false
    } ])

week_visits = ->
  ctx = document.getElementById('myChart')
  a = 0.05
  b = 2
  myChart = new Chart(ctx,
  type: 'bar'
  data:
    labels: [
      'Monday'
      'Tuesday'
      'Wendsday'
      'Thursday'
      'Friday'
      'Saturday'
      'Sunday'
    ]
    datasets: [ {
      label: 'Visits of restaurant during week'
      data: [
          a * 1 ^ 2 + b * 1 * Math.random()
          a * 2 ^ 2 + b * 2 * Math.random()
          a * 4 ^ 2 + b * 4 * Math.random()
          a * 6 ^ 2 + b * 4 * Math.random()
          a * 5 ^ 2 + b * 3 * Math.random()
          a * 8 ^ 2 + b * 10 * Math.random()
          a * 9 ^ 2 + b * 12 * Math.random()
      ]
      backgroundColor: [
        'rgba(255, 99, 132, 0.2)'
        'rgba(54, 162, 235, 0.2)'
        'rgba(255, 206, 86, 0.2)'
        'rgba(75, 192, 192, 0.2)'
        'rgba(153, 102, 255, 0.2)'
        'rgba(255, 159, 64, 0.2)'
        'rgba(255, 99, 132, 0.2)'
      ]
      borderColor: [
        'rgba(255,99,132,1)'
        'rgba(54, 162, 235, 1)'
        'rgba(255, 206, 86, 1)'
        'rgba(75, 192, 192, 1)'
        'rgba(153, 102, 255, 1)'
        'rgba(255, 159, 64, 1)'
        'rgba(255,99,132,1)'
      ]
      borderWidth: 1
    } ]
  options: scales: yAxes: [ { ticks: beginAtZero: true } ])
