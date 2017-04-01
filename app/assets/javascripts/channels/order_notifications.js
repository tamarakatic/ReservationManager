$(function() {
  if ($(document.body).data("page-name") === "provider_home") {

    App.order_notifications = App.cable.subscriptions.create("OrderNotificationsChannel", {
      received: function (notification) {
        $("#provider-notifications").removeClass("hidden")
        return $("#provider-notifications").html(this.renderNotification(notification));
      },
      renderNotification: function (data) {
        var show_msg = "Show Orders!";
        return "<p class='text-center'>" + data.notification + show_msg.link(".") + "</p>";
      }
    });
  }
});
