class ReservationMailer < ApplicationMailer
  default :from => "rm_invitations@gmail.com"

  def invitation_email(user, reservation)
    @user        = user
    @reservation = reservation

    mail :to => @user.email, :subject => "You have an invitation"
  end
end
