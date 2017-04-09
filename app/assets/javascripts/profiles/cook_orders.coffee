$(document).on 'ready turbolinks:load', ->

  $('#preparing').unbind('click').click (e) ->
    id = $('#orderId').val()
    $.ajax
      url: 'cook_orders/prepare'
      type: 'PUT'
      data: id: {id}


  $('#readyFood').unbind('click').click (e) ->
    order_id = $('#orderId').val()
    $.ajax
      url: 'cook_orders/finish'
      type: 'PUT'
      data: id: {order_id}