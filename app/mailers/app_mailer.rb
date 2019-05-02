class AppMailer < ApplicationMailer

  def send_release_copy
    mail(to: current_user.email, subject: 'Your copy of our release')
  end
end
