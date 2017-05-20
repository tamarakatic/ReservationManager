# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->

  $("#preparingdrink").unbind('click').click (e) ->
    customerOrderId = $('#orderid').val()
    drinkIds = $('#drinks').data('drink-ids')
    $.ajax
      url: 'bartender_orders/prepare'
      type: 'put'
      data: {
        customer_order_id: customerOrderId,
        drink_ids: drinkIds
      }

  $('#readydrinks').unbind('click').click (e) ->
    order_id = $('#orderid').val()
    $.ajax
      url: 'bartender_orders/finish'
      type: 'put'
      data: id: {order_id}
