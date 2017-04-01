$(function() {
  if ($(document.body).data("page-name") === "manager_home") {

    App.offer_notifications = App.cable.subscriptions.create("OfferNotificationsChannel", {
      received: function (notification) {
        $("#manager-notifications").removeClass('hidden')
        return $("#manager-notifications").html(this.renderNotification(notification));
      },
      renderNotification: function (data) {
        return "<p class='text-center'>" + data.notification + "</p>";
      }
    });
  }
});
