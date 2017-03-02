# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->

    $('#restaurantReview').unbind('click').click (e) ->
      review = $('#restaurantCombo option:selected').text()
      resId = $('#restaurantId').val()
      $(this).atrr('disable',true)
      $.ajax
        url: '/reservation_reviews/restaurant'
        type: 'POST'
        data: id: {review, resId}

    $('#foodReview').unbind('click').click (e) ->
      arr = []
      $("input#food").filter ->
        arr.push($(this).val())

      review = $('#foodsCombo option:selected').text()
      $(this).attr('disable',true)
      $.ajax
       url: '/reservation_reviews/foods'
       type: 'POST'
       data: id: {arr,review}

    $('#drinkReview').unbind('click').click (e) ->
      arr = []
      review = $('#drinksCombo option:selected').text()
      $("input#drink").filter ->
        arr.push($(this).val())
      $.ajax
        url: '/reservation_reviews/drinks'
        type: 'POST'
        data: id: {arr,review}