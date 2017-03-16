App.cook_notify = App.cable.subscriptions.create("CookNotifyChannel", {
  received: function(data) {
    var user = $('#waiterId').val()
    if(data.employee == user)
      $('#notifications').append("<p>"+data.content+". Messsage from "+data.firstname+" "+data.lastname+"</p>")
      Persist.save(user, data, 'local')
  }
})