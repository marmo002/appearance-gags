class UsersController < ApplicationController
  before_action :require_login, only: [:index, :update]
  before_action :authorized?, only: [:show, :pass_reset]

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
      redirect_to welcome_legal_path
      # flash[:primary] = "Fill our initial form and accept release to start booking"
    else
     # flash[:alert] = "Please fix errors"
     render :new
    end
  end

  def show
    @user = User.find params[:id]
    @upcomming_bookings = @user.bookings.upcomming.first(10)
    @past_bookings = @user.bookings.past.first(10)

  end

  def pass_reset
    @user = User.find params[:user_id]
    pass_response = @user.assign_random_password

    # send new password
    # to user by email
    AppMailer.user_new_password(@user.id, pass_response).deliver_later
    
    respond_to do |format|
      if pass_response
        format.json {
          render json: {
            status: "success",
            type: "primary",
            model: "user",
            message: "New password email on it's way",
          }
        }
        format.html {
          flash[:primary] = "New password email on it's way"
          redirect_back(fallback_location: root_path)          
        }
      else
        format.json { render json: @user.errors, status: :bad_request  }
        format.html {
          flash[:danger] = "Something wrong happened"
          redirect_back(fallback_location: root_path)
        }
      end
    end#respond_to end
  end

private

  def user_params

    params.require(:user).permit(
      :email,
      :phone,
      :password,
      :password_confirmation,
    )
  end

end
