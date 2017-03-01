# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("a[name='accept']").unbind("click").click (event) ->
    accept_till = $("#accept_till").val()

    today = new Date
    dd = today.getDate()
    mm = today.getMonth() + 1

    yyyy = today.getFullYear()
    if dd < 10
      dd = '0' + dd
    if mm < 10
      mm = '0' + mm
    today = mm + '/' + dd + '/' + yyyy

    if today > accept_till
      alert 'You can not accept! The offer has expired!'
      event.preventDefault()
      return
    else
      event.preventDefault()
      return

  chart()

chart = ->
  ctx = document.getElementById('myChart')
  myChart = new Chart(ctx,
  type: 'bar'
  data:
    labels: [
      'Red'
      'Blue'
      'Yellow'
      'Green'
      'Purple'
      'Orange'
    ]
    datasets: [ {
      label: '# of Visits of restaurant'
      data: [
        12
        19
        3
        5
        2
        3
      ]
      backgroundColor: [
        'rgba(255, 99, 132, 0.2)'
        'rgba(54, 162, 235, 0.2)'
        'rgba(255, 206, 86, 0.2)'
        'rgba(75, 192, 192, 0.2)'
        'rgba(153, 102, 255, 0.2)'
        'rgba(255, 159, 64, 0.2)'
      ]
      borderColor: [
        'rgba(255,99,132,1)'
        'rgba(54, 162, 235, 1)'
        'rgba(255, 206, 86, 1)'
        'rgba(75, 192, 192, 1)'
        'rgba(153, 102, 255, 1)'
        'rgba(255, 159, 64, 1)'
      ]
      borderWidth: 1
    } ]
  options: scales: yAxes: [ { ticks: beginAtZero: true } ])
