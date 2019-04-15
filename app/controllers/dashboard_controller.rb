class DashboardController < ApplicationController
  before_action :require_login

  def index
    # @user = User.find(current_user.id)
  end

  def user_update

    if current_user.update(user_params)
      flash[:primary] = "New info was saved"
      redirect_to dashboard_url
    else
      flash[:danger] = "Please review form"
      session[:user_errors] = current_user.errors.as_json(full_messages: true)
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
      :bio,
      :company_name,
      :companylogo,
      social_media: [ :profile, :facebook, :linkedin, :twitter, :instagram, :other ],
      company_social_media: [ :website, :facebook, :linkedin, :twitter, :instagram, :other ]
    )
  end

end
