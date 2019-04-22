class DashboardController < ApplicationController
  before_action :require_login
  before_action :authorized?, only: [ :admin_dashboard, :company_update ]

  def index
    if is_admin?
      redirect_to admin_url
    end
    @page = params[:tab]
    @upcomming_bookings = current_user.bookings.upcomming.first(10)
    @past_bookings = current_user.bookings.past.first(10)
  end

  def admin_dashboard
    @users = User.where.not(id: current_user.id).first(20)
    @upcomming_bookings = Booking.upcomming.first(10)
    @past_bookings = Booking.past.first(10)
  end

  def user_update
    if current_user.update(user_params)
      # flash[:primary] = "Profile updated successfully"
      # redirect_to dashboard_url
    else
      flash[:danger] = "Please review form"
      session[:user_errors] = current_user.errors.as_json(full_messages: true)
      # redirect_to dashboard_url
    end
  end

  def company_update
    if company.update(company_params)
      flash[:primary] = "New info was saved"
      redirect_to dashboard_url
    else
      flash[:danger] = "Please review form"
      session[:user_errors] = company.errors.as_json(full_messages: true)
      redirect_to dashboard_url
    end
  end

private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :avatar,
      :password,
      :password_confirmation,
      :name_for_show,
      :title_for_show,
      :signed_release,
      :bio,
      :company_name,
      :companylogo,
      social_media: [ :profile, :facebook, :linkedin, :twitter, :instagram, :other ],
      company_social_media: [ :website, :facebook, :linkedin, :twitter, :instagram, :other ]
    )
  end

  def company_params
    params.require(:company).permit(
      :name,
      :address1,
      :address2,
      :city,
      :province,
      :postal_code,
      :email,
      :phone,
      :fax,
      :release
    )
  end

end
