class UsersController < ApplicationController
  before_action :require_login, only: [:index, :update]
  before_action :authorized?, only: [:show]

  def index
    @users = User.where.not(id: current_user.id).first(33)
    if params[:search] && !params[:search].empty?
      @users = User.search(params[:search], current_user.id)
    end

    respond_to do |format|
      format.json {
        json_data = @users.map do |user|
          {
            "userId": user.id,
            "userName": user.full_name,
            "signed_release": user.signed_release,
            "email": user.email,
            "phone": user.phone
          }
        end
        render json: json_data
      }

      format.html
    end
  end

  def new
    redirect_to dashboard_url if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to welcome_path
      # flash[:primary] = "Fill our initial form and accept release to start booking"
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
