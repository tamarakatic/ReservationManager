# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->

  $('#dates').change ->
    comboDates = document.getElementById('dates')
    shiftDate = comboDates.options[comboDates.selectedIndex].text
    if(shiftDate == "Choose date" || shiftDate == "")
      $('div[class=col-sm-12]').filter ->
        $(this).css('background-color','#f442cb')
      return
    $.ajax
      url: '/profiles/employee_reon/seats'
      type: 'GET'
      data: id: shiftDate
      success: (data)->
        $('span').filter ->
          if $(this).text() == data.seat.area
            $('div[class=col-sm-12]').filter ->
                $(this).css('background-color','#f442cb')
            $(this).parent().css('background-color','green')



