class BookingsController < ApplicationController
  before_action :require_login
  before_action :authorized?, only: [:bookings_list]
  before_action :signed_release, only: [:new, :new_alt]
  before_action :redirect_admin, only: [:new]

  def index
    if is_admin?
      redirect_to bookings_list_path
      return
    end
    @upcomming_bookings = current_user.bookings.upcomming.first(10)
    @past_bookings = current_user.bookings.past.first(10)
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

  def new_alt
    @booking = Booking.new
    @user_social = current_user.get_social_media("social_media")
    @company_social = current_user.get_social_media("company_social_media")
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    user_info = {
      'full_name' => current_user.full_name,
      'email' => current_user.email,
      'phone' => current_user.phone,
      'release' => company.release,
      'dob' => current_user.dob,
      'user_location' => current_user.user_location,
      'company_legal' => {
        'legal_name' => current_user.company_legal_name,
        'phone_number' => current_user.company_phone,
        'company_address' => current_user.company_full_address
      }
    }
    @booking.user_info = @booking.user_info.merge(user_info)

    respond_to do |format|
      if @booking.save
        # check user consent for images
        # attach image(s) accordingtly
        set_booking_attachments(@booking)

        format.json {
          flash[:primary] = "Booking was created successfully"
          render json: {
            status: "success",
            type: "primary",
            message: "Booking was created successfully",
            model: "booking",
            booking_path: booking_path(@booking)
          }
        }
        format.html {
          flash[:primary] = "Booking was created successfully"
          redirect_to dashboard_url page: 'booking-history-tab'
        }
      else
        format.json { render json: @booking.errors, status: :bad_request }
        format.html {
          flash[:danger] = "Please review form"
          session[:booking_errors] = @booking.errors.as_json(full_messages: true)
          redirect_back(fallback_location: dashboard_path)
        }
      end
    end#respond_to end

  end

  def bookings_list
    @upcomming_bookings = Booking.upcomming.first(10)
    @past_bookings = Booking.past.first(10)
  end

  def get_recording_form
    render partial: "bookings/partials/recording_content"
  end

  def get_test_form
    render partial: "bookings/partials/test_content"
  end

  def booking_menu
    render partial: "bookings/partials/booking_menu"
  end

private

  def signed_release
    unless current_user.signed_release
      flash[:warning] = "Our release has been updated. Please read carefully and signed consent"
      redirect_to dashboard_url page: 'release-tab'
    end
  end

  def redirect_admin
    if is_admin?
      redirect_to dashboard_path
      return
    end
  end

  def set_booking_attachments(booking)
    # check image_consent
    # attach image(s) accordingtly
    if booking.user_info["image_consent"] == "true"
      booking.user_avatar.attach(current_user.avatar.blob)
    end
    
    # check logo_consent
    # attach image(s) accordingtly
    if booking.user_info["logo_consent"] == "true"
      booking.user_companylogo.attach(current_user.companylogo.blob)
    end
  end

  def booking_params

    params.require(:booking).permit(
      :booking_type,
      :show_name,
      :recording_date,
      :test_date,
      :info_confirmation,
      user_info: [
        :image_consent,
        :name_for_show,
        :title_for_show,
        :bio,
        :logo_consent,
        :company_name,
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
        :company_youtube
        ]
      ],
      hardware_requirements: [:audio, :video, :computer_type, :browser_type, :speed_check1, :speed_check2, :ping, :download, :upload ]
    )
  end


end#booking class
