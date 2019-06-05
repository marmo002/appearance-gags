class MediaFilesController < ApplicationController
  before_action :require_login
  before_action :authorized?, only: [:new, :create]

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
        format.json {
          # flash[:primary] = "Media file was created successfully"
          render json: {
            status: "success",
            type: "primary",
            message: "Media file was created successfully",
            model: "media_file",
            id: @media_file.id,
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
        # format.js
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
    render partial: "media_files/partials/admin_edit_form"
  end

  def update
    @media_file = MediaFile.find(params[:id])
    @user = @media_file.booking.user

    if is_admin?
      respond_to do |format|
        if @media_file.update(media_file_params)
          # approve media_file if not approve yet
          approve_media(@media_file)

          format.json {
            render json: {
              status: "success",
              type: "primary",
              message: "Digital file updated successfully"
            }
          }
          format.html {
            flash[:primary] = "Digital file updated successfully"
            redirect_to booking_url @media_file.booking
          }
          # format.js
        else
          format.json { render json: @media_file.errors, status: :bad_request  }
          format.html {
            flash[:danger] = "Please review form"
            session[:user_errors] = current_user.errors.as_json(full_messages: true)
            redirect_back(fallback_location: dashboard_path)
          }
        end
      end#respond_to end
    elsif current_user == @user

    else
      flash[:danger] = "Not allowed to visit this page"
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

private

def approve_media(media)
  unless media.is_approved
    media.booking.media_files.each { |media_item|
      media_item.is_approved = true
    }
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
