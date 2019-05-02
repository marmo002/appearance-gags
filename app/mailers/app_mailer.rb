class AppMailer < ApplicationMailer

  def send_release_copy
    mail(to: "marmo_02@hotmail.com", subject: 'Your copy of our release')
  end
end
