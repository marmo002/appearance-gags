class UsersController < ApplicationController
  before_action :require_login, only: [:index, :update]
  before_action :authorized?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
     # flash[:alert] = "Please fix errors"
     render :new
    end
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
