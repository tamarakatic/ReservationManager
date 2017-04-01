$(function() {
  if ($(document.body).data("employee-type") === "cook") {

    App.cook_orders = App.cable.subscriptions.create("CookOrdersChannel", {
      received: function (data) {
        var user = $("#waiterId").val();
        if (data.employee == user) {
          $("#notifications").append("<p>" + data.content + ". Messsage from " + data.firstname+" "+data.lastname + "</p>");
          Persist.save(user, data, "local");
        }
      }
    });

  }
});
