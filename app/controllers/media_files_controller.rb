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
            title: @media_file.title,
            audio_link: @media_file.audio_link,
            video_link: @media_file.video_link
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

private

  def media_file_params
    params.require(:media_file).permit(
      :title,
      :audio_link,
      :video_link
    )
  end
end
