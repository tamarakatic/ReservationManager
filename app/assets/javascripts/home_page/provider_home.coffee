# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("a[name='edit']").unbind("click").click (event) ->
    order_id = ($(this).attr 'href').split('=')[1]
    active_till =  document.getElementById(order_id).getAttribute('data-active-till')
    accept_offer = document.getElementById(order_id).getAttribute('data-offer-accept')

    today = new Date
    dd = today.getDate()
    mm = today.getMonth() + 1

    yyyy = today.getFullYear()
    if dd < 10
      dd = '0' + dd
    if mm < 10
      mm = '0' + mm
    today = mm + '/' + dd + '/' + yyyy

    if accept_offer is "accepted"
      alert 'This offer is accepted!'
      event.preventDefault()
      return

    if today > active_till
      alert 'You can not edit! The offer has expired!'
      event.preventDefault()
      return

  $(document).on "click", "#create_offer", create_offer
  $(document).on "click", "#edit_offer", edit_offer

create_offer = ->
  from = $("#active_from").val()
  active_from = moment(from).format("MM/DD/YYYY")
  till = $("#active_till").val()
  active_till = moment(till).format("MM/DD/YYYY")
  console.log(active_till)
  console.log(active_from)
  dat = $('#offer_time').val()
  datum = moment(dat).format("MM/DD/YYYY")

  if datum > active_till || datum < active_from
    alert 'Datetime is wrong! Pick other datetime!'
    event.preventDefault()
    return

  prices = {}

  $("tbody > tr").each (key, value) ->
    price = $("##{value.id} > td > input#price")[0].value
    prices[value.id] = price

  $.post "/offers", { offer_items: prices, order_id: $("#order_id")[0].value, delivery_time: $('#offer_time').val() }, (data) ->
    $('#offer_time').val()
    console.log(data)

edit_offer = ->
  from = $("#active_from").val()
  active_from = moment(from).format("MM/DD/YYYY")
  till = $("#active_till").val()
  active_till = moment(till).format("MM/DD/YYYY")
  console.log(active_till)
  console.log(active_from)
  dat = $('#offer_time').val()
  datum = moment(dat).format("MM/DD/YYYY")

  if datum > active_till || datum < active_from
    alert 'Datetime is wrong! Pick other datetime!'
    event.preventDefault()
    return

  prices = {}

  $("tbody > tr").each (key, value) ->
    price = $("##{value.id} > td > input#price")[0].value

    prices[value.id] = price
    console.log(prices)

  offer_id = $("#offer_id")[0].value
  $.ajax
    url: "/offers/#{offer_id}"
    type: 'PUT'
    data: { offer_items: prices, order_id: $("#order_id")[0].value, delivery_time: $('#offer_time').val() }
    success: (response) ->
      $('#offer_time').val()
