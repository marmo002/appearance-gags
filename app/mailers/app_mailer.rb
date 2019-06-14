class AppMailer < ApplicationMailer

  # sends copy of release to current_user
  def send_release_copy(user_id)
    @user = User.find(user_id)
    @company = Company.first
    mail(to: @user.email, subject: 'Your copy of our release')
  end

  # sends notification to user that
  # admin created a media_file
  def user_new_mediafile(user_id, media_id)
    @company = Company.first
    @user = User.find(user_id)
    @media_file = MediaFile.find(media_id)
    @booking = @media_file.booking
    mail(to: @user.email, subject: 'Media files are ready for your review')
  end

  # sends email to admin
  # when user write a edit note
  # to a recording/media_files
  def user_wrote_editnote(user_id, media_id)
    @company = Company.first
    @user = User.find(user_id)
    @media_file = MediaFile.find(media_id)
    @booking = @media_file.booking
    mail(to: @company.email, subject: "For admin: #{ @user.full_name} wrote an edit note")
    # CHANGE @USER.EMAIL TO COMPANY EMAIL OR PRODUCER EMAIL
  end

  def admin_approved_with_upload(user_id, media_id)
    @company = Company.first
    @user = User.find(user_id)
    @media_file = MediaFile.find(media_id)
    @booking = @media_file.booking

    @media_file.uploads.each_with_index { |file, i|
      filename = file.id.to_s + file.filename.extension_with_delimiter
      if ActiveStorage::Blob.service.respond_to?(:path_for)
       attachments.inline[filename] = File.read(ActiveStorage::Blob.service.send(:path_for, file.key))
      elsif ActiveStorage::Blob.service.respond_to?(:download)
       attachments.inline[filename] = file.download
      end
    }

    mail(to: @user.email, subject: "Your booking media was approved with upload")
  end

  def user_approved_media(user_id, media_id)
    @company = Company.first
    @user = User.find(user_id)
    @media_file = MediaFile.find(media_id)
    @booking = @media_file.booking

    mail(to: @company.email, subject: "For admin: #{ @user.full_name} approved media")
  end

  # email to admin with new booking info
  # when user creates new booking
  def new_booking_created(user_id, booking_id)
    @company = Company.first

    @user = User.find(user_id)
    @booking = Booking.find booking_id

    mail(to: @company.email, subject: "For admin: #{ @user.full_name} just created a booking")
  end

  # email to user with new
  # random generated password
  def user_new_password(user_id, password)
    @company = Company.first

    @user = User.find(user_id)
    @password = password

    mail(to: @user.email, subject: "Get a grip studios new password")
  end

end
