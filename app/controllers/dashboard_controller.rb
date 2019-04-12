class DashboardController < ApplicationController
  before_action :require_login

  def index
    # @user = User.find(current_user.id)
  end

  def user_update
    user = current_user
    if user.update(user_params)
      flash[:primary] = "Info saved"
      redirect_to dashboard_url
    else
      flash[:danger] = "Review form"
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
