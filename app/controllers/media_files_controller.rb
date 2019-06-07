class MediaFilesController < ApplicationController
  before_action :require_login
  before_action :authorized?, only: [:new, :create]

  def index
    @booking = Booking.find(params[:booking_id])
    @media_files = @booking.media_files
    render layout: false
  end

  # index for a list of bookings
  # where booking.media_files.count > 0
  def digital_files

  end

  def new
    @booking = Booking.find(params[:booking_id])
    @media_file = MediaFile.new

    render partial: "media_files/partials/form"
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @media_file = MediaFile.new(media_file_params)
    @media_file.booking = @booking

    respond_to do |format|
      if @media_file.save
        # notify user of new file bye email
        AppMailer.user_new_mediafile(@booking.user.id, @media_file.id).deliver_later

        format.json {
          render json: {
            status: "success",
            type: "primary",
            message: "Media file was created successfully",
            model: "media_file",
            id: @media_file.id,
            booking: @media_file.booking.id,
            title: @media_file.title,
            audio_link: @media_file.audio_link,
            video_link: @media_file.video_link,
            created_at: @media_file.created_at.strftime("%b %d, %Y"),
            count: @booking.media_files.count
          }
        }
        format.html {
          flash[:primary] = "Media file was created successfully"
          redirect_to booking_path(@booking)
        }
      else
        format.json { render json: @media_file.errors, status: :bad_request }
        format.html {
          flash[:danger] = "Please review form"
          render :new
        }
      end
    end#respond_to end

  end

  def edit
    @media_file = MediaFile.find(params[:id])
    render layout: false
  end

  def update
    @media_file = MediaFile.find(params[:id])
    @user = @media_file.booking.user

    if is_admin? || current_user == @user
      respond_to do |format|
        if @media_file.update(media_file_params)

          # approve media_file if not approve yet
          @media_file.approve_media if is_admin?

          #sends email confirming update
          email_notification_of_update(@user.id, @media_file.id)

          format.json {
            render json: {
              status: "success",
              type: "primary",
              message: "Digital file updated successfully",
              model: "media_file",
              booking: @media_file.booking.id
            }
          }
          format.html {
            flash[:primary] = "Digital file updated successfully"
            redirect_to booking_url @media_file.booking
          }
        else
          format.json { render json: @media_file.errors, status: :bad_request  }
          format.html {
            flash[:danger] = "Please review form"
            session[:user_errors] = current_user.errors.as_json(full_messages: true)
            redirect_back(fallback_location: dashboard_path)
          }
        end
      end#respond_to end
    else
      flash[:danger] = "You don't have permission to visist this page"
      redirect_to dashboard_url
      return
    end
  end

  def delete_upload
    @upload = ActiveStorage::Attachment.find(params[:id])

      if @upload
        @upload.purge_later

        flash[:primary] = "Upload was deleted successfully"
        redirect_back(fallback_location: dashboard_path)
      else
        flash[:danger] = "File not found"
        redirect_back(fallback_location: dashboard_path)
      end

  end

  def user_approve_media
    @media_file = MediaFile.find(params[:id])
    user_id = @media_file.booking.user.id

    if @media_file.approve_media
      # send admin a notification
      # that media was approved
      AppMailer.user_approved_media(user_id, @media_file.id).deliver_later

      flash[:primary] = "Media files were approved"
      redirect_back(fallback_location: dashboard_path)
    else
      flash[:danger] = "Media was not approved"
      redirect_back(fallback_location: dashboard_path)
    end

  end

private

  # on update,
  # if admin: sends email to user about media_file approval
  # if user: sends email to admin about user new edit note
  def email_notification_of_update(user_id, media_id)
    if is_admin?
      AppMailer.admin_approved_with_upload(user_id, media_id).deliver_later
    else
      AppMailer.user_wrote_editnote(user_id, media_id).deliver_later
    end
  end

  def media_file_params
    if is_admin?
      params.require(:media_file).permit(
        :title,
        :audio_link,
        :video_link,
        uploads: []
      )
    else
      params.require(:media_file).permit(
        :edit
      )
    end
  end

end
