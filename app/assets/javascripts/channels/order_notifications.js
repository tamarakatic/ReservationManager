App.order_notifications = App.cable.subscriptions.create("OrderNotificationsChannel", {
  received: function (notification) {
    $("#provider-notifications").removeClass('hidden')
    return $("#provider-notifications").append(this.renderNotification(notification));
  },
  renderNotification: function (data) {
    return "<p class='text-center'>" + data.notification + "</p>";
  }
});
