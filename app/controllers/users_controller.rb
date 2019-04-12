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
  #
  # def update
  #   user = current_user
  #   if user.update(user_params)
  #     flash[:primary] = "Info saved"
  #     head dashboard_url
  #   else
  #     flash[:alert] = "Review form"
  #     render "dashboard/index"
  #   end
  # end


private

  def user_params

    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :password,
      :password_confirmation,
      :name_for_show,
      :title_for_show,
      :bio,
      :company_name,
      social_media: [ :facebook, :linkedin, :twitter, :instagram, :other ],
      company_social_media: [ :website, :facebook, :linkedin, :twitter, :instagram, :other ]
    )
  end

end
