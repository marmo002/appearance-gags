class UsersController < ApplicationController
  before_action :require_login, only: [:index, :update]
  before_action :authorized?, only: [:show]

  def new
    redirect_to dashboard_url if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:user_profile_setup] = true
      redirect_to welcome_path
    else
     # flash[:alert] = "Please fix errors"
     render :new
    end
  end

  def profile_creation
    redirect_to dashboard_path unless session[:user_profile_setup]

  end

  def show
    @user = User.find params[:id]
    @upcomming_bookings = @user.bookings.upcomming.first(10)
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
      :bio,
      :company_name,
      :companylogo,
      social_media: [ :facebook, :linkedin, :twitter, :instagram, :other ],
      company_social_media: [ :website, :facebook, :linkedin, :twitter, :instagram, :other ]
    )
  end

end
