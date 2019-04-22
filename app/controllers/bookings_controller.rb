class BookingsController < ApplicationController
  before_action :require_login
  before_action :signed_release, only: [:new]
  before_action :redirect_admin

  def index

  end

  def new
    bookings_new_security
    @booking = Booking.new
    session[:show_name] = params[:show_name]
    session[:type] = params[:type]
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.show_name = session[:show_name]
    @booking.type = session[:type]

    if @booking.save
      flash[:primary] = "Booking created"
      redirect_to dashboard_url page: 'booking-history-tab'
    else
      render :new
      # redirect_back(fallback_location: new_booking_path)
    end
  end

private

  def signed_release
    unless current_user.signed_release
      flash[:warning] = "Please signed release before booking a show"
      redirect_to dashboard_url page: 'release-tab'
    end
  end

  def bookings_new_security
    unless params[:show_name] == "lighting" || params[:show_name] == "life"
      # flash[:warning] = "Wrong type of show"
      redirect_to bookings_path
      return
    end

    unless params[:type] == "in-studio" || params[:type] == "virtual"
      # flash[:warning] = "Wrong type of show location"
      redirect_to bookings_path
      return
    end
  end

  def redirect_admin
    if is_admin?
      redirect_to dashboard_path
      return
    end
  end

  def booking_params
    params.require(:booking).permit(
      :recording_date,
      :recording_time,
      :test_date,
      :test_time,
      :info_confirmation,
      user_info: [
        social_media: [
        :facebook,
        :linkedin,
        :twitter,
        :instagram,
        :other
        ],
        company_social_media: [
        :company_website,
        :company_facebook,
        :company_linkedin,
        :company_twitter,
        :company_instagram,
        :company_other
        ]
      ],
      hardware_requirements: [:headphone, :webcam, :ping, :download, :upload ]
    )
  end


end#booking class
