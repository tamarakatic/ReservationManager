# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->
    console.log("blaaa")

    $("#preparingDrink").unbind('click').click (e) ->
      id = $('#orderId').val()
      $.ajax
        url: 'bartender_orders/prepare'
        type: 'PUT'
        data: id: {id}


    $('#readyDrinks').unbind('click').click (e) ->
      order_id = $('#orderId').val()
      $.ajax
        url: 'bartender_orders/finish'
        type: 'PUT'
        data: id: {order_id}