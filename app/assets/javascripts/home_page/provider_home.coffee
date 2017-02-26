# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", "#create_offer", create_offer
  $(document).on "click", "#edit_offer", edit_offer

create_offer = ->
    prices = {}

    $("tbody > tr").each (key, value) ->
      price = $("##{value.id} > td > input#price")[0].value

      prices[value.id] = price
    $.post "/offers", { offer_items: prices, order_id: $("#order_id")[0].value }, (data) ->
      console.log(data)

edit_offer = ->
    prices = {}

    $("tbody > tr").each (key, value) ->
      price = $("##{value.id} > td > input#price")[0].value

      prices[value.id] = price
      console.log(prices)
    offer_id = $("#offer_id")[0].value
    console.log(offer_id)
    $.ajax
      url: "/offers/#{offer_id}"
      type: 'PUT'
      data: { offer_items: prices, order_id: $("#order_id")[0].value }
      success: (response) ->
        console.log(response)
