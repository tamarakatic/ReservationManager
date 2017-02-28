# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->

    $('#callModal').click ->
      $('#exfood').hide()
      $('#foodModal').modal 'show'

    $('#drinkModal').click ->
      $('#drinksModal').modal 'show'

    $('#food').unbind("click").click (e) ->
      food = document.getElementById('foodSelect')
      food_id = food.options[food.selectedIndex].value
      food_name = food.options[food.selectedIndex].text
      customer_order = $('#orderFood').val()
      if(food_id == '')
        return

      $.ajax
        url: '/table_orders.html'
        type: 'PUT'
        data: id: { food_id, customer_order }
        complete: (data) ->
          $('#foodModal').modal 'hide'


    $('#deleteFood').unbind('click').click (e) ->
      console.log("Brisem")
      food_id = $(this).prev().val()
      customer_id = $('#orderFood').val()
      $.ajax
        url: '/table_orders.html'
        type: 'DELETE'
        data: id: {food_id, customer_id}

    $('#foodList').unbind('click').on 'click','#exchangeFood', ->
      $('#food').hide()
      $('#foodModal').modal 'show'


    $('#exfood').unbind("click").click (e) ->
      food_id = $('#exchangeFood').prev().prev().val()
      food = document.getElementById('foodSelect')
      food_id_to_exchange = food.options[food.selectedIndex].value
      food_name = food.options[food.selectedIndex].text
      customer_order = $('#orderFood').val()
      if(food_id_to_exchange == '')
        return

      $.ajax
        url: '/table_orders/exchange.html'
        type: 'PUT'
        data: id: { food_id, customer_order, food_id_to_exchange }
        complete: (data) ->
          $('#foodModal').modal 'hide'


