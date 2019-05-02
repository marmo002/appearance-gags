class AppMailer < ApplicationMailer

  def send_release_copy(user, company_release)
    @user = user
    @release = company_release
    mail(to: @user.email, subject: 'Your copy of our release')
  end
end
