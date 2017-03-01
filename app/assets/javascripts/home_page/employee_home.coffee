# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ready turbolinks:load', ->

    id = $('#empId').val()
    arrNotif = Persist.load(id,'local')
    if arrNotif == null
      return

    if arrNotif.length > 0
      for x of arrNotif
        $('#notifs').append("<p>"+arrNotif[x].content+". Messsage from "+arrNotif[x].firstname+" "+arrNotif[x].lastname+"</p>")
