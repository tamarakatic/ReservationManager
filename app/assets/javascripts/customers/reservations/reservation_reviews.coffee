# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->

    $('#restaurantReview').unbind('click').click (e) ->
      review = $('#restaurantCombo option:selected').text()
      resId = $('#restaurantId').val()
      reservationId = $('#reservationId').val()
      $.ajax
        url: '/reservation_reviews/restaurant'
        type: 'POST'
        data: id: {review, resId, reservationId}

    $('#foodReview').unbind('click').click (e) ->
      arr = []
      reservationId = $('#reservationId').val()
      $("input#food").filter ->
        arr.push($(this).val())

      review = $('#foodsCombo option:selected').text()
      $.ajax
       url: '/reservation_reviews/foods'
       type: 'POST'
       data: id: {arr, review, reservationId}

    $('#drinkReview').unbind('click').click (e) ->
      arr = []
      reservationId = $('#reservationId').val()
      review = $('#drinksCombo option:selected').text()
      $("input#drink").filter ->
        arr.push($(this).val())
      $.ajax
        url: '/reservation_reviews/drinks'
        type: 'POST'
        data: id: {arr, review, reservationId}

    $('#waiterReview').unbind('click').click (e) ->
      review = $(this).next().find(":selected").text()
      reservationId = $('#reservationId').val()
      waiterId = $(this).prev().prev().prev().val()
      $.ajax
        url: '/reservation_reviews/waiters'
        type: 'POST'
        data: id: {review, reservationId, waiterId}