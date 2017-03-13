$(document).on("ready turbolinks:load", function() {
  if ($(document.body).data("page-name") === "provider_home") {

    App.provider_notifications = App.cable.subscriptions.create("ProviderNotificationsChannel", {
      received: function (notification) {
        $("#provider-notifications").removeClass("hidden");
        return $("#provider-notifications").html(this.renderNotification(notification));
      },
      renderNotification: function (data) {
        var user = $("#current_user").data("provider");

        if (data.confirmed_provider === user) {
          return "<p class='text-center'>" + data.confirmed_offer + data.message_confirmed + "</p>";
        }
        else if (data.rejected_providers.indexOf(user) != -1) {
          return "<p class='text-center'>" + data.message_rejected + "</p>";
        }
      }
    });
  }
});
