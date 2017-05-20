$(document).on 'ready turbolinks:load', ->

  $('#callModal').click ->
    $('#exfood').hide()
    $('#food').show()
    $('#foodModal').modal 'show'

  $('#drinkModal').click ->
    $('#exdrink').hide()
    $('#drink').show()
    $('#drinksModal').modal 'show'

  $('#food').unbind("click").click (e) ->
    food = document.getElementById('foodSelect')
    food_id = food.options[food.selectedIndex].value
    food_name = food.options[food.selectedIndex].text
    customer_order = $('#orderFood').val()
    if(food_id == '')
      return

    $.ajax
      url: '/table_orders/foods.html'
      type: 'PUT'
      data: id: { food_id, customer_order }
      complete: (data) ->
        $('#foodModal').modal 'hide'


  $('#drink').unbind('click').click (e) ->
    drink = document.getElementById('drinkSelect')
    drink_id = drink.options[drink.selectedIndex].value
    customer_order = $('#orderDrink').val()
    if(drink_id == '')
      return

    $.ajax
      url: '/table_orders/drinks.html'
      type: 'PUT'
      data: id: {drink_id, customer_order}
      complete: (data) ->
        $('#drinkModal').modal 'hide'


  $(document).unbind('click').on 'click', '.delete-btn', ->
    foodId = $(this).attr('id')
    customerOrderId = $('#orderFood').val()

    $.ajax
      url: '/table_orders'
      type: 'DELETE'
      data: {
        food_id: foodId,
        customer_order_id: customerOrderId
      }

  $(document).unbind('click').on 'click','.delete-drink-btn', ->
    drinkId = $(this).attr('id')
    customerOrderId = $('#orderFood').val()
    $.ajax
      url: '/table_orders/remove_drinks.html'
      type: 'DELETE'
      data: {
        drink_id: drinkId,
        customer_order_id: customerOrderId
      }

  $('#foodDiv').unbind('click').on 'click','#exchangeFood', ->
    $('#food').hide()
    $('#exfood').show()
    food_id = $(this).prev().prev().val()
    $('#foodModal').modal 'show'
    exchangeFood(food_id)

  $('#drinkDiv').unbind('click').on 'click', '#exchangeDrink', ->
    $('#drink').hide()
    $('#exdrink').show()
    drink_id = $(this).prev().prev().val()
    $('#drinksModal').modal 'show'
    exchangeDrink(drink_id)

  $('#foodList').unbind('click').on 'click', '#sendCooks', ->
    cook_id     = $(this).prev().find('option:selected').val()
    food_id     = $(this).prev().prev().prev().attr('id')
    customer_id = $('#orderFood').val()

    if(cook_id === "" || food_id === "" || customer_id === "")
      return

    $(this).attr('disabled',true)
    $(this).prev().prev().attr('disable',true)
    $(this).prev().prev().prev().attr('disable',true)

    $.ajax
      url: 'table_orders/notify_cook'
      type: 'POST'
      data: id:{cook_id, food_id, customer_id}

  $('#drinkList').unbind('click').on 'click', '#sendBartenders', ->
    bart_id     = $(this).prev().find('option:selected').val()
    drink_id    = $(this).prev().prev().prev().prev().val()
    customer_id = $('#orderFood').val()

    if(bart_id === "" || drink_id === "" || customer_id === "")
      return

    $(this).attr('disabled',true)
    $(this).prev().prev().attr('disable',true)
    $(this).prev().prev().prev().attr('disable',true)

    $.ajax
      url: 'table_orders/notify_bartender'
      type: 'POST'
      data: id:{bart_id, drink_id, customer_id}

exchangeFood = (food_id) ->
  $('#exfood').unbind("click").click (e) ->
      food = document.getElementById('foodSelect')
      food_id_to_exchange = food.options[food.selectedIndex].value
      customer_order = $('#orderFood').val()
      if(food_id_to_exchange == '')
        return

      $.ajax
        url: '/table_orders/exchange.html'
        type: 'PUT'
        data: id: { food_id, customer_order, food_id_to_exchange }
        complete: (data) ->
          $('#foodModal').modal 'hide'

exchangeDrink = (drink_id) ->
  $('#exdrink').unbind("click").click (e) ->
      drink = document.getElementById('drinkSelect')
      drink_id_to_exchange = drink.options[drink.selectedIndex].value
      customer_order = $('#orderFood').val()
      if(drink_id_to_exchange == '')
        return

      $.ajax
        url: '/table_orders/exchange_drink.html'
        type: 'PUT'
        data: id: { drink_id, customer_order, drink_id_to_exchange }
        complete: (data) ->
          $('#foodModal').modal 'hide'


