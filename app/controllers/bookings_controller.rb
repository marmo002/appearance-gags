class BookingsController < ApplicationController
  before_action :require_login
  before_action :signed_release, only: [:new]

  def index

  end

  def new
    bookings_new_security
    @booking = Booking.new
    @show = params[:show_name]
    @type = params[:type]
    @web = "I have over ear headphone with on-board over mouth microphone connected to your computer via USB port."
    @cam = "I have a webcam with the appropriate lighting and in a good recording environment (i.e no uncontrolled noises and where interruptions can be eliminated)."
    # @speed = "I have a webcam with the appropriate lighting and in a good recording environment (i.e no uncontrolled noises and where interruptions can be eliminated)."
  end

  def create
    @params = params
    # redirect_to_back fallback_location :root_path
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

end#booking class
