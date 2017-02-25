# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).ready(ready)
  $(document).on("turbolinks:load", ready)

ready = ->
  $("#pending-requests").on "click", ->
    $("#pending-requests").addClass("active")
    $("#all-friends").removeClass("active")
    $("#search-box").hide(300)
    $.get "pending_requests.html", (data) ->
        $("#friends-deck").html "#{data}"

  $("#all-friends").on "click", ->
    $("#all-friends").addClass("active")
    $("#pending-requests").removeClass("active")
    $("#search-box").show(300)
    $.get "friends.html", { layout: true }, (data) ->
        $("#friends-deck").html "#{data}"
