class BookingsController < ApplicationController
  before_action :require_login
  before_action :authorized?, only: [:bookings_list]
  before_action :signed_release, only: [:new]
  before_action :redirect_admin, only: [:new]
  before_action :allowed_to_see_booking, only: [:show]

  def index

  end

  def bookings_list
    @upcomming_bookings = Booking.upcomming.first(10)
    @past_bookings = Booking.past.first(10)
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
    @booking.booking_type = session[:type]
    user_info = {
      'full_name' => current_user.full_name,
      'email' => current_user.email,
      'phone' => current_user.phone,
      'name_for_show' => current_user.name_for_show,
      'title_for_show' => current_user.title_for_show,
      'bio' => current_user.bio,
      'release' => company.release
    }
    @booking.user_info = @booking.user_info.merge(user_info)

    if @booking.save
      flash[:primary] = "Booking created"
      session[:show_name] = nil
      session[:type] = nil
      redirect_to dashboard_url page: 'booking-history-tab'
    else
      render :new
      # redirect_back(fallback_location: new_booking_path)
    end
  end

  def show
    @booking = Booking.find(params[:id]) if Booking.exists?(['id = ?', "#{params[:id]}"])

    if @booking
      @user = @booking.user
      unless is_admin? || @user == current_user
        flash[:danger] = "Not allowed to visit this page"
        redirect_to dashboard_url
        return
      end
    else
      flash[:warning] = "Record does not exist"
      redirect_to dashboard_url
    end
  end

  def get_test_form
    # respond_to do |format|
    #   format.json {
    #     render
    #   }
    # end
    render partial: "bookings/partials/test_date_so_form"
  end

private
  def allowed_to_see_booking

  end

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
