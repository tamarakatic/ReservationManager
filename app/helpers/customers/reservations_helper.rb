module Customers::ReservationsHelper

  def invitation_status(invitation)
    case invitation.status.to_sym
    when :accepted
      content_tag :span, "Accepted", :class => "badge badge-success badge-pill"
    when :declined
      content_tag :span, "Declined", :class => "badge badge-danger badge-pill"
    when :pending
      content_tag :span, "Pending", :class => "badge badge-default badge-pill"
    when :canceled
      content_tag :span, "Canceled", :class => "badge badge-warning badge-pill"
    end
  end

end
