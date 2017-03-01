# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("a[name='accept']").unbind("click").click (event) ->
    accept_till = $("#accept_till").val()

    today = new Date
    dd = today.getDate()
    mm = today.getMonth() + 1

    yyyy = today.getFullYear()
    if dd < 10
      dd = '0' + dd
    if mm < 10
      mm = '0' + mm
    today = mm + '/' + dd + '/' + yyyy

    if today > accept_till
      alert 'You can not accept! The offer has expired!'
      event.preventDefault()
      return
    # else
    #   event.preventDefault()
    #   return
