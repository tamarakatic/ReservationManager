# Auto close alerts after 4 seconds

$ ->
  $(".alert-dismissable").delay(4000).slideUp 300, ->
    $(this).alert("close")

