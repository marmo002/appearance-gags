class UsersController < ApplicationController
  before_action :require_login, only: [:index, :update]

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

  def update
    user = current_user
    if user.update(user_params)
      flash[:primary] = "Info saved"
      head dashboard_url
    else
      flash[:alert] = "Review form"
      render "dashboard/index"
    end
  end


private

  def user_params

    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :password,
      :password_confirmation,
      personal_info: [
        :profile_pic,
        :name_on_show,
        :title_on_show,
        :bio,
        social_media: [ :facebook, :linkedin, :twitter, :instagram, :other ]
      ]
    )
  end

end
