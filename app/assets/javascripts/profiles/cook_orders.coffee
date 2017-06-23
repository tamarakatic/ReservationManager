$(document).on 'ready turbolinks:load', ->

  $('#preparing').unbind('click').click (e) ->
    orderId = $('#orderId').val()
    foodIds = $('#foods').data('food-ids')

    $.ajax
      url: 'cook_orders/prepare'
      type: 'PUT'
      data: {
        order_id: orderId,
        food_ids: foodIds
      }


  $('#readyFood').unbind('click').click (e) ->
    order_id = $('#orderId').val()
    $.ajax
      url: 'cook_orders/finish'
      type: 'PUT'
      data: id: {order_id}
