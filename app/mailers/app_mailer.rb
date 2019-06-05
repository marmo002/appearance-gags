class AppMailer < ApplicationMailer

  def send_release_copy(user_id)
    @user = User.find(user_id)
    @company = Company.first
    mail(to: @user.email, subject: 'Your copy of our release')
  end

  def user_new_mediafile(user_id, media_id)
    @company = Company.first
    @user = User.find(user_id)
    @media_file = MediaFile.find(media_id)
    @booking = @media_file.booking
    mail(to: @user.email, subject: 'Media files are ready for your review')

  end
end
