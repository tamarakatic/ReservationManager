# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load',->

  $('#finishButton').unbind('click').click (e) ->
    order_id = $('#orderId').val()
    $.ajax
     url: 'waiter_orders'
     type: 'PUT'
     data: id: {order_id}
