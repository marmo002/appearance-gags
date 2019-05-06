class AppMailer < ApplicationMailer

  def send_release_copy(user_id)
    @user = User.find(user_id)
    @company = Company.first
    mail(to: @user.email, subject: 'Your copy of our release')
  end
end
