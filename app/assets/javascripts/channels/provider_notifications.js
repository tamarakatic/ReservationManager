App.provider_notifications = App.cable.subscriptions.create("ProviderNotificationsChannel", {
  received: function (notification) {
    $("#provider-notifications").removeClass('hidden')
    return $("#provider-notifications").html(this.renderNotification(notification));
  },
  renderNotification: function (data) {
    console.log(data)
    var user = $("#current_user").data("provider")

    if (data.confirmed_provider === user) {
      return "<p class='text-center'>" + data.message_confirmed + "</p>";
    }
    else if (data.rejected_providers.indexOf(user) != -1) {
      return "<p class='text-center'>" + data.message_rejected + "</p>";
    }
  }
});
